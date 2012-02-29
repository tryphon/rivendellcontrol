require 'ipaddr'
require 'socket'

module HostValidation

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def validates_host(*names)
      options = names.extract_options!
      validates_each names do |record, attr, value|
        unless value.blank? and options[:allow_blank]
          record.errors.add attr, :not_valid_hostname unless record.validate_host value
        end
      end
    end

  end

  def validate_host(host)
    if host =~ /^[0-9\.]+$/
      IPAddr.new(host, Socket::AF_INET)
    else
      Socket.gethostbyname(host)
    end

    true
  rescue
    false
  end

end
