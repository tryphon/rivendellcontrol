require 'spec_helper'

describe UserInterface::FlashHelper do

  describe "flash_tag" do
    
    it "should be nil if flash is empty" do
      helper.flash_tag({}).should be_nil
    end

    it "should return a #flash div" do
      helper.flash_tag(:level => "message").should have_tag("div[id=flash]")
    end

    it "should return a div for each flash entry (level, message)" do
      helper.flash_tag(:level => "message").should have_tag("div[class=level]", "message")
    end

    it "should return a div for each flash entry (level, message)" do
      helper.flash_tag(:level => "message").should have_tag("div[class=level]", "message")
    end

    it "should sanitize messages" do
      helper.should_receive(:sanitize).with("message")
      helper.flash_tag(:level => "message")
    end

  end

end
