# -*- coding: utf-8 -*-
require 'spec_helper'

describe ActsAsIpPort do
  # Only include into ModelExampleGroup
  include Remarkable::ActiveRecord::Matchers

  class TestActsAsIpPort < ActiveForm::Base
    include ActsAsIpPort
    acts_as_ip_port :port
    acts_as_ip_port :user_port, :user_port => true
    acts_as_ip_port :optionnal_port, :allow_blank => true
  end

  before(:each) do
    @model = TestActsAsIpPort.new
  end

  it "should define a reader method" do
    @model.should respond_to(:port)
  end

  it "should define a writer method" do
    @model.should respond_to(:port=)
  end

  it "should convert the given port into an integer" do
    @model.port = "8000"
    @model.port.should == 8000
  end

  it "should accept only a integer value" do
    @model.should allow_values_for(:port, 8000)
  end

  it "should not accept a negative value" do
    @model.should_not allow_values_for(:port, -1)
  end

  it "should not accept value greather than 65535" do
    @model.should_not allow_values_for(:port, 65536)
  end

  it "should not accept value blank value by default" do
    @model.should_not allow_values_for(:port, "")
  end

  context "when allow_blank is true" do

    it "should accept value blank value" do
      @model.should allow_values_for(:optionnal_port, "")
    end
    
  end

  describe "user port" do

    it "should not accept value lower than 1025" do
      @model.should_not allow_values_for(:user_port, 1024)
    end
    
  end

end
