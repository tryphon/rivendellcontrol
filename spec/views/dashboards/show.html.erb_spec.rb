require 'spec_helper'

describe "/dashboards/show" do
  before(:each) do
    render 'dashboards/show'
  end

  it "should display title" do
    response.should have_tag('h1', "Dashboard")
  end
end
