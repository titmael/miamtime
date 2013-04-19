class Vote < ActiveRecord::Base
  belongs_to :option
  belongs_to :user

  attr_accessible :username
  
  validates_presence_of :option
end
