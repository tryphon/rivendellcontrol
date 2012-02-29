class NetworkPresenter

  attr_accessor :network

  def initialize(network)
    @network = network
  end

  def method_name
    NetworkPresenter.method_name(@network.method)
  end

  def self.static_method_name
    method_name(:static)
  end

  def self.dhcp_method_name
    method_name(:dhcp)
  end

  def self.method_name(method)
    I18n.translate("networks.method.#{method}")
  end

end
