require 'spec_helper'

describe "/logs/show" do

  let(:log) { Log.new }

  before(:each) do
    log.stub :last_lines => %w{line1 line2 line3}
    assigns[:log] = log
  end

  it "should display log last lines in a text area" do
    render
    response.should have_tag("textarea", /#{log.last_lines}/)
  end

  it "should have a link to download log" do
    render
    response.should have_tag("a[href=?]", log_path(:format => :gz))
  end

  it "should a form to reload page with search" do
    render
    response.should have_tag("form[action=?][method=get]", log_path)
  end

  it "should a search input in form" do
    render
    response.should have_tag("form") do
      with_tag("input[name=search]")
    end
  end

end
