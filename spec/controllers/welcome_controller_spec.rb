require 'spec_helper'

describe WelcomeController do
  describe "GET 'index'" do
    it "should redirect to the Dashboard" do
      get 'index'
      response.should redirect_to(dashboard_path)
    end
  end
end
