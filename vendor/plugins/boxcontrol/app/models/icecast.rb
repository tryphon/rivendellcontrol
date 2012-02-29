class Icecast < ActiveForm::Base
  include PuppetConfigurable

  attr_accessor :clients
  attr_accessor :source_password

  validates_numericality_of :clients, :only_integer => true, :greater_than => 0, :less_than => 100

  validates_presence_of :source_password
  validates_format_of :source_password, :with => %r{^[^<]*$}, :allow_blank => true
  
  def after_initialize
    self.clients ||= 5
  end

  def new_record?
    false
  end

  def available?
    valid? and port_respond?
  end

  def url(public_host = host)
    "http://#{public_host}:#{port}"
  end

  def host
    "localhost"
  end

  def port
    8000
  end
  
  def port_respond?(timeout = 5)
    begin
      timeout(timeout) do
        s = TCPSocket.new(host, port)
        s.close
      end
    rescue Timeout::Error, StandardError
      return false
    end
    return true
  end

end
