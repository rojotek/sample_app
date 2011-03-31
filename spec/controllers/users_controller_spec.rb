require 'spec_helper'

describe UsersController do
  #render_views is required to make the actions perfom html output
  render_views
  
  def get_should_be_success(action, params=nil)
      get action, params
      response.should be_success
  end
  
  describe "GET 'show" do
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get_should_be_success(:show, id: @user)
    end
    
    it "should find the right user" do
      get :show, id: @user
      assigns(:user).should == @user
    end                             
    
    it "should have the right title" do
      get :show, id: @user
      response.should have_selector('title', content: @user.name)
    end
    
    it "should include the users name" do
      get :show, id: @user
      response.should have_selector('h1', content: @user.name)
    end
    
    it "should have a profile image" do
      get :show, id: @user
      response.should have_selector('h1>img', class: "gravatar round")
    end
    
  end
  
  describe "POST 'create'" do
    describe 'failure' do
       before(:each) do
         @attr={name:"", email: "", password: "", password_confirmation: ""}
       end
       it "should not create a user" do
         lambda do
           post :create, user: @attr
         end.should_not change(User, :count)
       end
       it "should have the right title" do
         post :create, user: @attr
         response.should have_selector("title", content: "Sign up")
       end
       it "should render the 'new' page" do
         post :create, user: @attr
         response.should render_template("new")
       end
    end
    describe 'success' do
      before(:each) do
        @user = Factory(:user)
      end
      it "should be successful" do
          post 'create', user: @user.attributes
          response.should be_success
      end
      it "should create a user"
    end
  end
  describe "GET 'new'" do
    it "should be successful" do
      get_should_be_success(:new)
    end
                              
    it "should have the right title" do
      get :new     
      # Render views is required for the following line to work!
      response.should have_selector('title', content: "Sign up")
    end
    
  end

end
