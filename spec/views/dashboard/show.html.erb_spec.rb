require 'spec_helper'

describe "/dashboards/show" do
  before(:each) do
    render
  end

  it "should display title" do
    response.should have_selector('h1', :text => "Dashboard")
  end
end
