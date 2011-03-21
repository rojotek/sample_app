require 'spec_helper'

describe User do
  before(:each) do
    @attr = {name:"Rob Dawson", email: "robert@rojotek.com", password: "PassW0rd!", password_confirmation: "PassW0rd!"}
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
    attr = @attr.merge(name: long_name)
    user = User.new(attr)
    user.should_not be_valid
  end

  it "should require an email" do
    attr = @attr.merge(email:"")
    user = User.new(attr)
    user.should_not be_valid
  end
  
  describe "email" do
    it "should not allow invalid email" do
      invalid_emails = %w{no_at ends_with_at@ part_domain@bbb}
      invalid_emails.each do |invalid_email|
        attr = @attr.merge(email: invalid_email)
        user = User.new(attr)
        user.should_not be_valid
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
      attr = @attr.merge(name: "other")
      user = User.new(attr)
      user.should_not be_valid
    end   
    it "should be unique case-insensitively" do
      User.create!(@attr)
      
      invalid_emails =%w{ROBert@rojoteK.Com ROBERT@rojotek.com robert@rojotek.COM}
      invalid_emails.each do |invalid_email|
        attr = @attr.merge(email: invalid_email)
        user = User.new(attr)
        user.should_not be_valid
      end
    end
  end
  def passwords_invalid(password, password_confirmation)
    attr = @attr.merge(password: password, password_confirmation: password_confirmation)
    user = User.new(attr)
    user.should_not be_valid
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
  
end
