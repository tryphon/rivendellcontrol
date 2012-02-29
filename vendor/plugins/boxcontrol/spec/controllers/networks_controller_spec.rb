require 'spec_helper'

describe NetworksController do

  before(:each) do
    @network = Network.new
    @network.stub!(:save).and_return(true)
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end

    it "should render show view" do
      get 'show'
      response.should render_template("show")
    end

    it "should define @network by load a new instance" do
      Network.should_receive(:load).and_return(@network)
      get 'show'
      assigns[:network].should == @network
    end

  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end

    it "should render edit view" do
      get 'edit'
      response.should render_template("edit")
    end

    it "should define @network by load a new instance" do
      Network.should_receive(:load).and_return(@network)
      get 'edit'
      assigns[:network].should == @network
    end

  end

  describe "PUT 'update'" do

    before(:each) do
      @params = { "dummy" => true }
      Network.stub!(:new).and_return(@network)
    end

    it "should create a Network instance with form attributes" do
      Network.should_receive(:new).with(@params).and_return(@network)
      post 'update', :network => @params
    end

    it "should save the Network instance" do
      @network.should_receive(:save).and_return(true)
      post 'update'
    end

    describe "when network is successfully saved" do

      before(:each) do
        @network.stub!(:save).and_return(true)
      end
      
      it "should redirect to network path" do
        post 'update'
        response.should redirect_to(network_path)
      end

      it "should define a flash notice" do
        post 'update'
        flash.should have_key(:success)
      end

    end

    describe "when network isn't saved" do

      before(:each) do
        @network.stub!(:save).and_return(false)
      end
      
      it "should redirect to edit action" do
        post 'update'
        response.should render_template("edit")
      end

      it "should define a flash failure" do
        post 'update'
        flash.should have_key(:failure)
      end

    end

  end
end
