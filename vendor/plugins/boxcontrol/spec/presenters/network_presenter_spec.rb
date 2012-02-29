# -*- coding: utf-8 -*-
require 'spec_helper'

describe NetworkPresenter do

  before(:each) do
    @presenter = NetworkPresenter.new(@network = mock(Network))
  end

  it "should return the method name if the current network method" do
    @network.stub!(:method).and_return("dummy")
    NetworkPresenter.should_receive(:method_name).with("dummy").and_return("dummy name")
    @presenter.method_name.should == "dummy name"
  end

  describe "class method method_name" do

    it "should use the i18n 'networks.method.' key with the given method" do
      I18n.should_receive(:translate).with("networks.method.dummy").and_return("dummy 18n")
      NetworkPresenter.method_name(:dummy).should == "dummy 18n"
    end
    
  end

end
