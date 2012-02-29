require 'spec_helper'

describe UserInterface::LocaleManagement do

  after(:each) do
    I18n.locale = nil
  end
  
  class TestLocaleManagement
    @@before_filters = []
    cattr_reader :before_filters

    def self.before_filter(name)
      before_filters << name
    end

    attr_reader :user_session
    def initialize(user_session)
      @user_session = user_session
    end

    def params
      {}
    end

    def logger
      Rails.logger
    end

    include UserInterface::LocaleManagement
  end

  let(:user_session) { mock UserInterface::UserSession, :language => :fr, :language= => nil }
  let(:locale_management) { TestLocaleManagement.new user_session }

  it "should add a before_filter :change_locale" do
    locale_management.before_filters.should == [ :change_locale ]
  end

  it "should change I18n.locale to UserSession#langague" do
    locale_management.send(:change_locale)
    I18n.locale.should == user_session.language
  end

  context 'when params :lang is present' do

    before(:each) do
      locale_management.stub!(:params).and_return(:lang => "dummy")
    end

    it "should change UserSession#language" do
      user_session.should_receive(:language=).with("dummy")
      locale_management.send(:change_locale)
    end

  end

end
