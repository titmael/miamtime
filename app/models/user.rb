class User < ActiveRecord::Base
  has_many :surveys
  attr_accessible :hash_validation, :name, :password, :email
  validates_presence_of :hash_validation, :name, :password, :email
  validates :email, :email_format => {:message => 'mauvais format d\'email'}
end
