require 'spec_helper'

describe LanguagesHelper do

  describe "link_to_language" do
    
    it "should use image_tag('ui/flags/<language>.gif')" do
      helper.should_receive(:image_tag).with('ui/flags/dummy.gif').and_return("image_tag_for_flag")
      helper.link_to_language("dummy").should have_tag("a", "image_tag_for_flag")
    end

    it "should link to the given language" do
      helper.should_receive(:language_path).with('dummy').and_return("/languages/dummy")
      helper.link_to_language("dummy").should have_tag("a[href=?]", "/languages/dummy")
    end

    it "should use put method" do
      helper.should_receive(:link_to).with(anything, anything, hash_including(:method => :put))
      helper.link_to_language("dummy")
    end

    it "should use a translate title" do
      helper.should_receive(:translate).with("languages.link_to_language", :locale => "dummy").and_return("link_title")
      helper.link_to_language("dummy").should have_tag("a[title=link_title]")
    end

  end

  describe "links_to_languages" do
    
    it "should concat link_to_language for en and fr" do
      helper.should_receive(:link_to_language).with(:en).and_return("link_to_language_en")
      helper.should_receive(:link_to_language).with(:fr).and_return("link_to_language_fr")
      helper.links_to_languages.should == "link_to_language_en link_to_language_fr"
    end

  end

end
