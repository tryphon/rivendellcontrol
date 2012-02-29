require 'spec_helper'

describe "/inputs/edit" do

  before(:each) do
    assigns[:input] = @input = AlsaInput.new
  end

  it "should render partial given by InputPresenter#form_partial" do
    @input.stub_chain(:presenter, :form_partial).and_return(stub)
    template.should_receive(:render).with(@input.presenter.form_partial).and_return('<div id="partial"/>')
    render
    response.should have_tag("form #partial")
  end

end
