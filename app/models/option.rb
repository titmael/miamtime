class Option < ActiveRecord::Base
  belongs_to :survey
  has_many :votes
  attr_accessible :locality, :title, :votes
  validates_presence_of :locality
end
