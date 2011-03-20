require 'spec_helper'

describe UsersController do
  #render_views is required to make the html out
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
                              
    it "should have the right title" do
      get :new     
      # Render views is required for the following line to work!
      response.should have_selector('title', :content => "Sign up")
    end
    
  end

end
