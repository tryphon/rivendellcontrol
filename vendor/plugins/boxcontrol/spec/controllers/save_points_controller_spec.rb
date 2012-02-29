require 'spec_helper'

describe SavePointsController do

  before(:each) do
    @save_point = SavePoint.new
  end

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should render new view" do
      get 'new'
      response.should render_template("new")
    end

    it "should define @save_point with a new instance" do
      SavePoint.should_receive(:new).and_return(@save_point)
      get 'new'
      assigns[:save_point].should == @save_point
    end

  end

  describe "POST 'create'" do

    before(:each) do
      @params = { "dummy" => true }
      SavePoint.stub!(:new).and_return(@save_point)
    end

    it "should create a SavePoint instance with form attributes" do
      SavePoint.should_receive(:new).with(@params).and_return(@save_point)
      post 'create', :save_point => @params
    end

    it "should save the SavePoint instance" do
      @save_point.should_receive(:save).and_return(true)
      post 'create'
    end

    describe "when save point is successfully saved" do

      before(:each) do
        @save_point.stub!(:save).and_return(true)
      end
      
      it "should redirect to save point path" do
        post 'create'
        response.should redirect_to(new_save_point_path)
      end

      it "should define a flash notice" do
        post 'create'
        flash.should have_key(:success)
      end

    end

    describe "when save point isn't saved" do

      before(:each) do
        @save_point.stub!(:save).and_return(false)
      end
      
      it "should redirect to new action" do
        post 'create'
        response.should render_template("new")
      end

      it "should define a flash failure" do
        post 'create'
        flash.should have_key(:failure)
      end

    end

  end
end
