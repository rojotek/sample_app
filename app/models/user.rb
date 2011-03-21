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
class User < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i               
  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, format: {with: email_regex}, uniqueness: {case_sensitive: false}
  validates :password, 
    confirmation: true, 
    presence: true, 
    length: {minimum:6, maximum: 50},
    format: {with: /[a-z]/}
  validates :password, password: true
  # validates :password, format: {with: /[0-9]/}
    # format: {with: }
end
