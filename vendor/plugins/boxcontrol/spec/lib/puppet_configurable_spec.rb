# -*- coding: utf-8 -*-
require 'spec_helper'

describe PuppetConfigurable do

  class TestConfigurable
    attr_accessor :attributes
    alias_method :update_attributes, :attributes=

    include PuppetConfigurable

    def initialize(attributes = {})
      @attributes = attributes
    end
  end

  before(:each) do
    @configurable = TestConfigurable.new(@attributes = { :dummy => true })

    @puppet_configuration = mock(PuppetConfigurable, :save => true).tap do |m|
      m.stub!(:update_attributes).and_return(m)
    end

    PuppetConfiguration.stub!(:load).and_return(@puppet_configuration)
  end

  describe "puppet_configuration_prefix" do
    
    it "should return the underscored class name" do
      @configurable.puppet_configuration_prefix.should == "test_configurable"
    end

  end

  describe "save" do

    it "should return true if the configuration is saved" do
      @configurable.save.should be_true
    end

    it "should return false if the network isn't valid" do
      @configurable.stub!(:valid?).and_return(false)
      @configurable.save.should be_false
    end

    it "should update puppet configuration attributes with its attributes" do
      @puppet_configuration.should_receive(:update_attributes).with(@configurable.attributes, anything).and_return(@puppet_configuration)
      @configurable.save
    end

    it "should not modifiy puppet configuration if not valid" do
      @puppet_configuration.should_not_receive(:update_attributes)
      @configurable.stub!(:valid?).and_return(false)
      @configurable.save
    end

    it "should update puppet configuration with prefix given by puppet_configuration_prefix" do
      @puppet_configuration.should_receive(:update_attributes).with(anything, @configurable.puppet_configuration_prefix).and_return(@puppet_configuration)
      @configurable.save
    end

  end

  describe "load" do

    it "should retrieve puppet configuration attributes with puppet_configuration_prefix" do
      @puppet_configuration.should_receive(:attributes).with(@configurable.puppet_configuration_prefix).and_return(:dummy => "dummy")
      @configurable.load
      @configurable.attributes[:dummy].should == "dummy"
    end

    it "should not save the loading model (ticket #2)" do
      @puppet_configuration.stub :attributes => {:dummy => true}

      @configurable.should_not_receive(:save)
      @configurable.load
    end

  end


  describe "class method load" do
    
    it "should create a new instance and load it" do
      TestConfigurable.should_receive(:new).and_return(@configurable)
      @configurable.should_receive(:load)
      TestConfigurable.load.should == @configurable
    end

  end

  describe "update_attributes" do
    
    it "should save the instance" do
      @configurable.should_receive(:save)
      @configurable.update_attributes(:dummy => true)
    end

  end

end
