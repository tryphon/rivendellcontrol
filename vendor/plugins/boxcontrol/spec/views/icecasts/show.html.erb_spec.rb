require 'spec_helper'

describe "/icecasts/show" do

  let(:icecast) { Icecast.new }

  before(:each) do
    assigns[:icecast] = icecast
  end

  it "should display Icecast#clients" do
    render
    response.should have_tag("p", /#{icecast.clients}/)
  end

  it "should display Icecast#source_password" do
    icecast.source_password = "dummy"
    render
    response.should have_tag("p", /#{icecast.source_password}/)
  end

  it "should display 'undefined' when no source password is defined" do
    icecast.source_password = nil
    template.stub :t => "dummy"
    template.should_receive(:t).with(".undefined").and_return("undefined")
    render
    response.should have_tag("p", /undefined/)
  end

  it "should display Icecast url when available" do
    icecast.stub :available? => true, :url => "http://icecast"
    render
    response.should have_tag("a[href=#{icecast.url}]", icecast.url)
  end

  it "should not display Icecast url when available" do
    icecast.stub :available? => false, :url => "http://icecast"
    render
    response.should_not have_tag("a[href=?]", "http://icecast")
  end

end
