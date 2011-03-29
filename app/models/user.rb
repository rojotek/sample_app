# == Schema Information
# Schema version: 20110314070234
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
require "digest"
class User < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i               
  
  attr_accessor :password
  
  # list of fields that can accept bulk updates
  attr_accessible :name, :email, :password, :password_confirmation
  
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, format: {with: email_regex}, uniqueness: {case_sensitive: false}
  validates :password, 
    confirmation: true, 
    presence: true, 
    length: {minimum: 6, maximum: 50},
    password: true 
    
  before_save :encrypt_password

  def self.authenticate(email, submitted_password)
    user = User.find_by_email(email)
    return user if user and user.has_password?(submitted_password)
  end
  
  def has_password?(submitted_password)
    return encrypt(submitted_password)==encrypted_password
  end
  
  private 
    def make_salt
        secure_hash("#{Time.now.utc}")
    end
    
    def encrypt_password
       self.salt = make_salt if new_record?
       self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{self.salt}--#{string}") #return string
    end
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
