class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :options, :dependent => :destroy

  accepts_nested_attributes_for :options
  attr_accessible :creation, :end_votes, :hash_url, :locality, :password, :title, :when_date, :when_text, :options_attributes

  validates :options, :length => {:minimum => 1}
end
