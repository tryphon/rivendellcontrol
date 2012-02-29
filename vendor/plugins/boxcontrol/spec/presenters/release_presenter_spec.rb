require 'spec_helper'

describe ReleasePresenter, :type => :helper do

  let(:release) { Release.new }
  let(:presenter) { ReleasePresenter.new release }

  describe "#default_status" do
    
    it "should humanize Release status" do
      release.status = "dummy"
      presenter.default_status.should == "Dummy"
    end
    
  end

  describe "human_status" do
    
    it "should use the translation of releases.status.<release.status>" do
      release.status = :dummy
      I18n.should_receive(:translate).with("releases.status.dummy", anything).and_return("Dummy")
      presenter.human_status.should == "Dummy"
    end

    it "should use default_status as default translation" do
      presenter.stub!(:default_status).and_return("default status")
      I18n.should_receive(:translate).with(anything, :default => "default status")
      presenter.human_status
    end

  end

end
