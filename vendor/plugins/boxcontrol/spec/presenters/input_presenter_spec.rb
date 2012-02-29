require 'spec_helper'

describe InputPresenter do

  let(:input) { mock(Input) }
  let(:presenter) { InputPresenter.new(input) }

  describe "partial name" do

    it "should use underscored class name" do
      input.stub_chain(:class, :name).and_return("ClassName")      
      presenter.partial_name.should == "class_name"
    end
    
  end 

  describe "partial" do
    
    it "should the :partial returned by partial_name" do
      presenter.partial.should include(:partial => presenter.partial_name)
    end

    it "should the input as :object" do
      presenter.partial.should include(:object => input)
    end

  end

  describe "form_partial" do

    let(:form) { stub }
    
    it "should the :partial form_<partial_name>" do
      presenter.form_partial(form).should include(:partial => "form_" + presenter.partial_name)
    end

    it "should the specified form as local form" do
      presenter.form_partial(form).should include(:locals => { :form => form})
    end

  end

end
