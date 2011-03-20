require 'spec_helper'

describe User do
  before(:each) do
    @attr = {name:"Rob Dawson", email: "robert@rojotek.com"}
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
  
end
