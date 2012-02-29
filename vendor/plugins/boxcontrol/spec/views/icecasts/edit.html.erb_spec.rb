require 'spec_helper'

describe "/icecasts/edit" do

  before(:each) do
    assigns[:icecast] = @icecast = Icecast.new
  end

  it "should provide a textfield for Icecast#source_password" do
    render
    response.should have_tag("input[type=text][name=?]", "icecast[source_password]")
  end

  it "should provide a textfield for Icecast#clients" do
    render
    response.should have_tag("input[type=text][name=?]", "icecast[clients]")
  end

end
