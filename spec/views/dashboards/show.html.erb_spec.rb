require 'spec_helper'

describe "/dashboards/show" do
  before(:each) do
    assigns[:events] = @events = Array.new(3) { |n| Event.create! :severity => :info, :message => "dummy" }
    render 'dashboards/show'
  end

  it "should display last events" do
    response.should have_tag('table[class=events]') do
      with_tag("td","Dummy", @events.size)
    end
  end
end
