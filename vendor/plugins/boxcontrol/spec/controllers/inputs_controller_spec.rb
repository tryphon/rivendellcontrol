require 'spec_helper'

describe InputsController do

  shared_examples_for "an action on Input instance" do

    it "should load the Input instance" do
      Input.should_receive(:current).and_return(Input.new)
      make_request
    end
    
  end


  describe "GET 'show'" do

    def make_request
      get 'show'
    end

    it "should be successful" do
      make_request
      response.should be_success
    end

    it_should_behave_like "an action on Input instance"

  end

  describe "GET 'edit'" do

    def make_request
      get 'edit'
    end

    it "should be successful" do
      make_request
      response.should be_success
    end

    it_should_behave_like "an action on Input instance"

  end

  describe "PUT 'update'" do
    
    def make_request
      put 'update'
    end

    it "should be successful" do
      make_request
      response.should be_success
    end
    
    it_should_behave_like "an action on Input instance"

  end

end
