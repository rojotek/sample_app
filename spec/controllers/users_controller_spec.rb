require 'spec_helper'

describe UsersController do
  #render_views is required to make the actions perfom html output
  render_views
  
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
      should_have_title :show, @user.name, id: @user
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
        @attr={name:"Rob Dawson", 
          email: "robert@rojotek.com", 
          password: "Pa55word!", 
          password_confirmation: "Pa55word!"}
      end
      it "should redirect to the user show page" do
          post 'create', user: @attr
          response.should redirect_to(user_path(assigns(:user)))
      end
      it "should create a user" do
        lambda do
          post 'create', user: @attr
        end.should change(User, :count).by(1)
      end
      it "should have a welcome message" do
        post 'create', user: @attr
        flash[:success].should =~ /Welcome to the Sample App/i
      end
      it "should sign the user in" do
        post 'create', user: @attr
        controller.should be_signed_in
      end
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
    it 'should have a name field' do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end 
    
    it 'should have an email field' do
      get :new
      response.should have_selector("input[name='user[email]'][type='text']")
    end
    
    it 'should have a password field' do
      get :new
      response.should have_selector("input[name='user[password]'][type='password']")
      
    end
    
    it 'should have a password confirmation field' do
      get :new
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
    
  end

end
