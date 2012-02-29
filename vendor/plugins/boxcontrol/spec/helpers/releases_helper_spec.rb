require 'spec_helper'

describe ReleasesHelper do

  let(:release) { stub_model(Release, :description_url => "dummy://url") }

  describe "link_to_description" do
    it "should return a link to Release#description_url" do
      helper.link_to_description(release).should have_link_to(release.description_url)
    end

    it "should return a link with class 'view'" do
      helper.link_to_description(release).should have_tag("a[class=view]")
    end

    it "should use i18n 'releases.description' as text" do
      helper.should_receive(:translate).with('releases.actions.description').and_return("i18n text")
      helper.link_to_description(release).should have_tag("a", "i18n text")
    end
  end

  describe "link_to_action" do
    
    context "when release is downloaded" do
      
      before(:each) do
        release.status = :downloaded
      end

      it "should return a link to install_release_path" do
        helper.link_to_action(release).should have_link_to(install_release_path(release))
      end

    end

    context "when release is download_pending" do
      
      before(:each) do
        release.status = :download_pending
      end

      it "should return a link to releases_path" do
        helper.link_to_action(release).should have_link_to(releases_path)
      end

      it "should return a link with download-pending class (for javascript ReleaseDownloadObserver)" do
        helper.link_to_action(release).should have_tag("a[class=download-pending release]")
      end

    end

    context "when release is in another state" do
      
      before(:each) do
        release.status = :available
      end

      it "should return a link to releases_path" do
        helper.link_to_action(release).should have_link_to(download_release_path(release))
      end

    end

  end

end
