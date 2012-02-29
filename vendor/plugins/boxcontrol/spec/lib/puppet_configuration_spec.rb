# -*- coding: utf-8 -*-
require 'spec_helper'

describe PuppetConfiguration do

  before(:each) do
    @puppet_configuration = PuppetConfiguration.new
  end

  after(:each) do
    delete_configuration_file
  end

  def delete_configuration_file
    File.delete(PuppetConfiguration.configuration_file) if File.exists?(PuppetConfiguration.configuration_file)
  end

  describe "load" do
    
    def configuration_with(content)
      File.open(PuppetConfiguration.configuration_file, "w") do |f|
        if Hash === content
          content.each_pair do |key, value| 
            f.puts "$#{key}=\"#{value}\""
          end
        else
          f.puts content
        end
      end
    end

    it "should parse $key=\"value\" entries" do
      configuration_with('$key="value"')
      @puppet_configuration.load
      @puppet_configuration[:key].should == "value"
    end

    it "should ignore invalid line" do
      configuration_with('dummy')
      @puppet_configuration.load
      @puppet_configuration.should be_empty
    end

    it 'should support \n in values' do
      configuration_with('$key="value1\nvalue2"')
      @puppet_configuration.load
      @puppet_configuration[:key].should == "value1\nvalue2"
    end

  end

  describe "save" do

    def configuration
      File.readlines(PuppetConfiguration.configuration_file).collect(&:strip)
    end

    it "should return true if the configuration is saved" do
      @puppet_configuration.save.should be_true
    end

    it "should return false if the configuration can't be saved" do
      @puppet_configuration.stub!(:configuration_file).and_return("/dummy")
      @puppet_configuration.save.should be_false
    end

    it "should store configuration attribute as $key=\"value\"" do
      @puppet_configuration[:key] = "value"
      @puppet_configuration.save
      configuration.should include("$key=\"value\"")
    end

    it 'should use \n for new lines in values'  do
      @puppet_configuration[:key] = "value1\nvalue2"
      @puppet_configuration.save
      configuration.should include('$key="value1\nvalue2"')
    end

    it 'should remove \r from values'  do
      @puppet_configuration[:key] = "value1\r\nvalue2"
      @puppet_configuration.save
      configuration.should include('$key="value1\nvalue2"')
    end

    it "should run the system_update_command if defined" do
      @puppet_configuration.stub!(:system_update_command).and_return("dummy")
      @puppet_configuration.should_receive(:system).with(@puppet_configuration.system_update_command).and_return(true)
      @puppet_configuration.save
    end

    it "should return false if the system_update_command isn't successfully executed" do
      @puppet_configuration.stub!(:system_update_command).and_return("dummy")
      @puppet_configuration.stub!(:systen).and_return(false)
      @puppet_configuration.save.should be_false
    end

    it "should not store configuration if transaction is pending" do
      PuppetConfiguration.stub!(:pending_transaction?).and_return(true)
      File.should_not_receive(:open)
      @puppet_configuration.save.should be_true
    end
   
  end

  describe "attributes" do
    
    it "should return the attributes with the given prefix (without the prefix in the keys)" do
      @puppet_configuration[:prefix_key] = "value"
      @puppet_configuration.attributes(:prefix).should == { :key => "value" }
    end

    it "should be empty without attributes" do
      @puppet_configuration.attributes.should be_empty
    end

    it "should return all the configuration attributes when the prefix is blank" do
      @puppet_configuration[:key] = "value"
      @puppet_configuration.attributes("").should == { :key => "value"}
    end

  end

  describe "update_attributes" do

    it "should modify the configuration with given entries" do
      @puppet_configuration.update_attributes(:key => "value")
      @puppet_configuration[:key].should == "value"
    end

    it "should prefix keys with given prefix" do
      @puppet_configuration.update_attributes({:key => "value"}, "prefix")
      @puppet_configuration[:prefix_key].should == "value"
    end

    it "should return the instance" do
      @puppet_configuration.update_attributes({:key => "value"}).should == @puppet_configuration
    end

  end

  describe "clear" do
    
    it "should remove keys with given prefix" do
      @puppet_configuration[:prefix_key] = "value"
      @puppet_configuration.clear(:prefix)
      @puppet_configuration[:prefix_key].should be_nil
    end

    it "should keep keys with doesn't match the prefix" do
      @puppet_configuration[:key] = "value"
      @puppet_configuration.clear(:prefix)
      @puppet_configuration[:key].should == "value"
    end

    it "should clear all keys without prefix" do
      @puppet_configuration[:key] = "value"
      @puppet_configuration.clear
      @puppet_configuration.should be_empty
    end

    it "should return the PuppetConfiguration instance" do
      @puppet_configuration.clear.should == @puppet_configuration
    end

  end

  describe "transaction" do

    it "should instance a single PuppetConfiguration" do
      PuppetConfiguration.should_receive(:new).and_return(@puppet_configuration)
      PuppetConfiguration.transaction do
        3.times do 
          PuppetConfiguration.load.should == @puppet_configuration
        end
      end
    end

    it "should save once PuppetConfiguration after transaction" do
      PuppetConfiguration.stub!(:new).and_return(@puppet_configuration)
      @puppet_configuration.should_receive(:save)
      PuppetConfiguration.transaction do
      end
    end
    
  end

end
