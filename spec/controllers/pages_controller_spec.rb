require 'spec_helper'

describe PagesController do
  render_views
                  
  before (:each) do
    @base_title = "Ruby on Rails Tutorial Sample App | "
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get_should_be_success :home
    end   
    it "should have the right title" do
      should_have_title(:home, @base_title + "Home")
    end
    
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get_should_be_success :contact
    end
    it "should have the right title" do
      should_have_title(:contact, @base_title + "Contact")
    end
    
  end

  describe "GET 'about'" do
    it "should be successful" do
      get_should_be_success :about
    end
    it "should have the right title" do
      should_have_title(:about, @base_title + "About")
    end
  end 

  describe "GET 'help'" do
    it "should be successful" do
      get_should_be_success 'help'
    end
    it "should have the right title" do
      should_have_title(:help, @base_title + "Help")
    end
  end
end
