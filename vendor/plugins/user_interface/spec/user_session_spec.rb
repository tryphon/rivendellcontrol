require 'spec_helper'

describe UserInterface::UserSession do

  let(:session) { {} } 
  subject { UserInterface::UserSession.new(session) } 

  describe "#language" do
    
    it "should use language attribute stored in session" do
      session.should_receive(:[]).with(:language).and_return("dummy")
      subject.language.should == "dummy"
    end

  end

  describe "#language=" do
    
    it "should replace an unknown language by I18n.default_locale" do
      I18n.stub :default_locale => "default"
      subject.language = "dummy"
      subject.language.should == "default"
    end

    it "should replace nil by I18n.default_locale" do
      I18n.stub :default_locale => "default"
      subject.language = nil
      subject.language.should == "default"
    end

  end

end
