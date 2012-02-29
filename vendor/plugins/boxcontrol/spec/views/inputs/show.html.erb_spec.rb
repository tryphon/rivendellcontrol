require 'spec_helper'

describe "/inputs/show" do

  before(:each) do
    assigns[:input] = @input = AlsaInput.new
  end

  describe "title" do

    it "should be Input.human_name" do
      Input.stub!(:human_name).and_return("Dummy")
      render
      response.should have_tag("h1", Input.human_name)
    end
                     
  end

  it "should display a link to edit the input" do
    render
    response.should have_link_to(edit_input_path)
  end

  it "should render partial given by InputPresenter#partial" do
    template.should_receive(:render).with(@input.presenter.partial).and_return('<div id="partial"/>')
    render
    response.should have_tag(".description #partial")
  end

end
