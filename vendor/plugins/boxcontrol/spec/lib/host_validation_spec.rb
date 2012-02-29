# -*- coding: utf-8 -*-
require 'spec_helper'

describe HostValidation do

  class TestHostValidation < ActiveForm::Base
    include HostValidation

    attr_accessor :host
    validates_host :host

    attr_accessor :optional_host
    validates_host :optional_host, :allow_blank => true
  end

  before(:each) do
    @model = TestHostValidation.new
  end

  describe "validate_host" do

    it "should be true when host is a valid ip address" do
      @model.validate_host("192.168.0.1").should be_true
    end

    it "should be false when host isn't a valid ip address" do
      @model.validate_host("192.168.0.256").should be_false
    end

    it "should be true when host is found by Socket.gethostbyname" do
      Socket.should_receive(:gethostbyname).with("found_host")
      @model.validate_host("found_host").should be_true
    end

    it "should be false when host isn't found by Socket.gethostbyname" do
      Socket.stub!(:gethostbyname).and_raise(SocketError)
      @model.validate_host("dummy").should be_false
    end

  end

  it "should validate host with validate_host method" do
    @model.host = "localhost"
    @model.should_receive(:validate_host).with(@model.host).and_return(false)
    @model.should have(1).error_on(:host)
  end

  it "should accept blank value with allow_blank options" do
    @model.optional_host = ""
    @model.should_not have(1).error_on(:optional_host)
  end

end
