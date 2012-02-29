require 'spec_helper'

describe UserInterface::TitleHelper do

  describe "title" do

    it "should define @title when a value is given" do
      helper.title "dummy"
      assigns[:title].should == "dummy"
    end

    it "should return @title when no argument is given" do
      assigns[:title] = "dummy"
      helper.title.should == "dummy"
    end

  end

  describe "title_tag" do
    
    it "should a h1 tag with title" do
      helper.should_receive(:title).with("dummy").and_return("title value")
      helper.title_tag("dummy").should have_tag("h1","title value")
    end

    describe "when a title is given" do

      it "should return a h1 tag with given title" do
        helper.title_tag("dummy").should have_tag("h1","dummy")
      end

      it "should define @title" do
        helper.title_tag("dummy")
        assigns[:title].should == "dummy"
      end
      
    end

  end

end
