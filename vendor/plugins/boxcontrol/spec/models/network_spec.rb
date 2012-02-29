# -*- coding: utf-8 -*-
require 'spec_helper'

describe Network do

  def delete_configuration_file
    File.delete(PuppetConfiguration.configuration_file) if File.exists?(PuppetConfiguration.configuration_file)
  end

  before(:each) do
    @network = Network.new
  end

  after(:each) do
    delete_configuration_file
  end

  describe "by default" do

    def self.it_should_use(value, options)
      attribute = options[:as] 
      it "should use #{value} as #{attribute}" do
        @network.send(attribute).should == value
      end
    end

    it_should_use "dhcp", :as => :method
    it_should_use "192.168.1.100", :as => :static_address
    it_should_use "255.255.255.0", :as => :static_netmask
    it_should_use "192.168.1.1", :as => :static_gateway
    it_should_use "192.168.1.1", :as => :static_dns1
  end

  it { should validate_inclusion_of :method, :in => %w{dhcp static} }

  describe "when method is static" do

    before(:each) do
      @network.method = "static"
      @network.static_netmask = "0.0.0.0"
    end

    it "should validate presence of static attributes" do
      @network.should validate_presence_of(:static_address, :static_netmask, :static_gateway, :static_dns1) 
    end

    def self.it_should_validate_ip_address(attribute)
      it "should validate that #{attribute} is a valid ip address" do
        @network.should allow_values_for(attribute, "192.168.0.1", "172.10.10.1", "10.0.0.254")
        @network.should_not allow_values_for(attribute, "192.168.0", "192.168.0.256", "abc")
      end
    end

    it_should_validate_ip_address :static_address
    it_should_validate_ip_address :static_dns1

    it "should validate that static dns1 is not the static address" do
      @network.should allow_values_for(:static_dns1, @network.static_address)
    end

    describe "default gateway" do

      before(:each) do
        @network.static_address = "192.168.0.10"
        @network.static_netmask = "255.255.255.0"
      end

      it "should be a valid ip address" do
        @network.should allow_values_for(:static_gateway, "192.168.0.1")
        @network.should_not allow_values_for(:static_gateway, "192.168.0", "192.168.0.256", "abc")
      end

      it "should be in local network" do
        @network.should_not allow_values_for(:static_gateway, "172.10.0.1")
      end

      it "should be the static ip address" do
        @network.should_not allow_values_for(:static_gateway, @network.static_address)
      end
      
    end

    
  end

  describe "when method is dhcp" do

    before(:each) do
      @network.method = "dhcp"
    end

    it "should not validate presence of static attributes" do
      @network.should_not validate_presence_of(:static_address, :static_netmask, :static_gateway, :static_dns1) 
    end

  end
  
  describe "save" do
    
    before(:each) do
      @puppet_configuration = PuppetConfiguration.new
      PuppetConfiguration.stub!(:load).and_return(@puppet_configuration)
    end

    def self.it_should_configure(attribute, options = {})
      configuration_key = (options[:as] or attribute.to_s)
      value = options[:value]

      it "should configure #{attribute} as #{configuration_key}" do
        @network.send("#{attribute}=", value)
        @network.save
        @puppet_configuration[configuration_key].should == value
      end
    end

    it_should_configure :method, :as => "network_method", :value => "dhcp"
    it_should_configure :static_address, :as => "network_static_address", :value => "192.168.1.2"
    it_should_configure :static_netmask, :as => "network_static_netmask", :value => "255.255.255.0"
    it_should_configure :static_gateway, :as => "network_static_gateway", :value => "192.168.1.1"
    it_should_configure :static_dns1, :as => "network_static_dns1", :value => "192.168.1.1"

  end

  describe "load" do
    
    before(:each) do
      @puppet_configuration = PuppetConfiguration.new
      PuppetConfiguration.stub!(:load).and_return(@puppet_configuration)
    end

    def self.it_should_use(configuration_key, options = {})
      attribute = (options[:as] or configuration_key)
      value = options[:value]

      it "should use #{configuration_key} as #{attribute} attribute" do
        @puppet_configuration[configuration_key] = value
        @network.load
        @network.send(attribute).should == value
      end
    end

    it_should_use :network_method, :as => :method, :value => "dhcp"
    it_should_use :network_static_address, :as => :static_address, :value => "192.168.1.2"
    it_should_use :network_static_netmask, :as => :static_netmask, :value => "255.255.255.0"
    it_should_use :network_static_gateway, :as => :static_gateway, :value => "192.168.1.1"
    it_should_use :network_static_dns1, :as => :static_dns1, :value => "192.168.1.1"

  end

  it "should not be a new record" do
    @network.should_not be_new_record
  end

end
