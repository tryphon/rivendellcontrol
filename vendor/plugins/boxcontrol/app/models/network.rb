require 'ipaddr'
require 'socket'

class Network < ActiveForm::Base
  include PuppetConfigurable

  attr_accessor :method
  attr_accessor :static_address, :static_netmask, :static_gateway, :static_dns1

  validates_inclusion_of :method, :in => %w{dhcp static}

  with_options :if => :manual? do |static|
    static.validates_presence_of :static_address, :static_netmask, :static_gateway, :static_dns1
    static.validate :must_use_valid_ip_addresses
    static.validate :must_use_valid_gateway_in_network
  end

  def after_initialize
    self.method ||= "dhcp"
    self.static_address ||= "192.168.1.100"
    self.static_netmask ||= "255.255.255.0"
    self.static_gateway ||= "192.168.1.1"
    self.static_dns1 ||= "192.168.1.1"
  end

  def manual?
    self.method == "static"
  end

  def new_record?
    false
  end

  def presenter
    @presenter ||= NetworkPresenter.new(self)
  end

  private

  def must_use_valid_ip_addresses
    [:static_address, :static_gateway, :static_dns1].each do |attribute|
      begin
        IPAddr.new(send(attribute), Socket::AF_INET) if errors.on(attribute).blank?
      rescue
        errors.add(attribute, :not_a_valid_ip_address)
      end
    end

    if errors.on(:static_address).blank? and errors.on(:static_netmask).blank?
      begin
        IPAddr.new("#{static_address}/#{static_netmask}", Socket::AF_INET)
      rescue
        errors.add(:static_netmask, :not_a_valid_netmask)
      end
    end
  end

  def must_use_valid_gateway_in_network
    if errors.on(:static_address).blank? and errors.on(:static_netmask).blank? and errors.on(:static_gateway).blank?
      if static_address == static_gateway
        errors.add(:static_gateway, :can_be_the_static_address)
      end

      static_gateway_ip = 
        begin
          IPAddr.new(static_gateway)
        rescue 
          errors.add(:static_gateway, :not_a_valid_ip_address)
        end

      unless IPAddr.new("#{static_address}/#{static_netmask}", Socket::AF_INET).include?(static_gateway_ip)
        errors.add(:static_gateway, :not_in_local_network)
      end
    end
  end

  def must_use_valid_dns
    if errors.on(:static_address).blank? and errors.on(:static_dns1).blank?
      if static_address == static_dns1
        errors.add(:static_dns1, :can_be_the_static_address)
      end
    end
  end

end
