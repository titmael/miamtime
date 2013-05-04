class Option < ActiveRecord::Base
  belongs_to :survey
  has_many :votes, :dependent => :destroy

  accepts_nested_attributes_for :votes
  attr_accessible :locality, :title, :votes_attributes
  validates_presence_of :locality, :message => "Vous devez avoir au moins une option non vide"
end
