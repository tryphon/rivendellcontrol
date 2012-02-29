require 'open-uri'

class Release < ActiveRecord::Base

  default_scope :order => 'name'

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :status

  after_save :change_current

  def after_initialize
    self.status_updated_at ||= Time.now
    self.status ||= :available
  end

  @@latest_url = nil
  cattr_accessor :latest_url

  def self.check_latest
    Loader.save_release_at(latest_url) do |release|
      release.status = :available
      release.newer?(last)
    end
  end

  @@current_url = nil
  cattr_accessor :current_url

  def self.check_current
    Loader.save_release_at(current_url) do |release|
      release.status = :installed
      true
    end
  end

  def self.check
    check_current
    check_latest
  end

  def self.latest
    latest = last
    latest.reset_download_status if latest and latest.newer?(current)
  end

  def self.current
    find_by_status("installed")
  end

  def human_name
    name.gsub("_"," ").capitalize.gsub("box","Box")
  end

  def status
    status = read_attribute :status
    status ? ActiveSupport::StringInquirer.new(status) : nil
  end

  def status=(status, update_timestamp = true)
    write_attribute :status, status ? status.to_s : nil
    self.status_updated_at = Time.now unless new_record?
  end

  def file
    "/tmp/release.tar"
  end

  def newer?(other)
    other.nil? or (self.name and self.name > other.name)
  end

  def presenter
    @presenter ||= ReleasePresenter.new self
  end

  def download!
    return if self.status.downloaded?

    update_attribute :status, :download_pending

    File.open(file, "w") do |file|
      Downloader.open(url) do |data, download_size, url_size|
        file.write data

        self.url_size ||= url_size
        self.download_size = download_size
        save! if 10.seconds.ago > self.updated_at
      end
    end

    raise "Invalid checksum after download" unless valid_checksum?
    self.status = :downloaded
  ensure
    self.status = :download_failed unless self.status.downloaded?
    save!
  end

  def start_download
    return if self.status.downloaded?

    update_attribute :status, :download_pending
    send_later :download!
  end

  def reset_download_status
    if %w{download_pending downloaded}.include?(status) and 
        status_updated_at < 30.seconds.ago and 
        not file_exists?

      update_attributes :status => :download_failed, :url_size => nil, :download_size => nil
    end

    self
  end

  @@install_command = nil
  cattr_accessor :install_command

  def install
    tempfile_with_attributes do |yaml_file|
      logger.info "Install #{self.inspect} : #{install_command} #{file} #{yaml_file}"
      system "#{install_command} #{file} #{yaml_file}"
    end
  end

  def tempfile_with_attributes(&block)
    Tempfile.open("release-#{name}") do |yaml_file|
      yaml_file.puts self.attributes.to_yaml
      yaml_file.flush

      yield yaml_file.path
    end
  end

  def valid_checksum?
    checksum and checksum == file_checksum
  end

  def file_checksum
    Digest::SHA256.file(file).hexdigest if file_exists?
  end

  def file_exists?
    File.exists?(file)
  end

  def change_current
    return unless status.installed?

    (Release.find_all_by_status("installed") - [self]).each do |old_release|
      old_release.update_attribute :status, :old
    end
  end

  class Loader

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def self.release_at(url)
      new(url).release if url
    end

    def self.save_release_at(url)
      if release = release_at(url)
        release.save unless block_given? and not yield release
      end
    end

    def attributes
      @attributes ||= YAML.load open(url,&:read) 
    rescue => e
      Rails.logger.error "Can't load attributes from #{url} : #{e}"
      {}
    end

    def supported_attributes
      attributes.reject do |attribute, _|
        not Release.column_names.include? attribute.to_s
      end
    end

    def release
      Release.find_or_create_by_name supported_attributes["name"], supported_attributes
    end

  end

end
