require 'spec_helper'

describe User do
  before(:each) do
    @attr = {name:"Rob Dawson", email: "robert@rojotek.com", password: "PassW0rd!", password_confirmation: "PassW0rd!"}
  end
  def invalid_user_for_attr(attrs) 
    attr = @attr.merge(attrs)
    user = User.new(attr)
    user.should_not be_valid
  end

  it "should create a user with when given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    attr = @attr.merge(name:"")
    user = User.new(attr)
    user.should_not be_valid
  end                                  
  it "should not allow long names" do
    long_name = 'a'*51
    invalid_user_for_attr(name: long_name)
  end

  it "should require an email" do
    attr = @attr.merge(email:"")
    invalid_user_for_attr(attr)
  end
  
  describe "email" do
    it "should not allow invalid email" do
      invalid_emails = %w{no_at ends_with_at@ part_domain@bbb}
      invalid_emails.each do |invalid_email|
        invalid_user_for_attr(email: invalid_email)
      end
    end
    it "should allow valid email" do
      valid_emails = %w{robert@rojotek.com FiRST@bbb.com.au other@domain.in.jp robert.dawson@here.com fire@here-to.com}
      valid_emails.each do |valid_email|
        attr = @attr.merge(email: valid_email)
        user = User.new(attr)
        user.should be_valid
      end
    end
    it  "should be unique" do
      User.create!(@attr)
      invalid_user_for_attr(name: "other")
    end   
    it "should be unique case-insensitively" do
      User.create!(@attr)
      
      invalid_emails =%w{ROBert@rojoteK.Com ROBERT@rojotek.com robert@rojotek.COM}
      invalid_emails.each do |invalid_email|
        invalid_user_for_attr(email: invalid_email)
      end
    end
  end
  
  def passwords_invalid(password, password_confirmation)
    invalid_user_for_attr(password: password, password_confirmation: password_confirmation)
  end  
  
  describe "password validations" do
    it "should require a password" do   
      passwords_invalid "", ""
    end
    
    it "should require a matching password confirmation" do
      passwords_invalid "Passw0rd", "Wrong"
    end
    
    it "should reject short passwords" do
      passwords_invalid "Abc12", "Abc12"
    end

    it "should reject long passwords" do
      as = 'a'*47
      long = "Lon3"+as
      passwords_invalid long, long
    end
    
    it "should require a number" do
      passwords_invalid "Password", "Password"
    end
    
    it "should require a lowercase char" do  
      passwords_invalid "PASSWORD1", "PASSWORD1"
    end
    
    it "should require a uppercase char" do
      passwords_invalid "password1", "password1"
    end
  end 
  
  it "should respond to encrypted password" do
    user = User.new(@attr)
    user.should respond_to(:encrypted_password)
  end
  
  it "should store an encrypted password" do
    user = User.create!(@attr)                 
    user.encrypted_password.should_not be_blank
  end
  
  describe "has_password? method" do
    it "should be true when correct password is given" do
      user = User.create!(@attr)
      user.has_password?("PassW0rd!").should be_true
    end                               
    it "should be false when incorrect password is given" do
      user = User.create!(@attr)
      user.has_password?("wrong_password").should be_false
    end                               
  end  
  describe "authenticate method" do
    it "should give user when email and password match" do
      User.create!(@attr)
      User.authenticate(@attr[:email], @attr[:password]).should be_true
    end
    it "should give nil when email and password differ " do
      User.create!(@attr)
      User.authenticate(@attr[:email], "wrong_pass").should be_blank
      
    end
  end
end
