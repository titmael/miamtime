# encoding: utf-8
class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :options, :dependent => :destroy

  accepts_nested_attributes_for :options
  attr_accessible :creation, :end_votes, :end_text, :hash_url, :locality, :when_date, :when_text, :options_attributes, :password, :password_confirmation, :locality_id

  validates_presence_of :password, :message => "le mot de passe ne peut être vide", :on => :create
  validates_presence_of :password_confirmation, :message => "la confirmation du mot de passe ne peut être vide", :on => :create
  validates_confirmation_of :password, :message => "les mots de passe ne correspondent pas", :on => :create

  validates :options, :length => {:minimum => 1, :message => "Vous devez avoir au moins une option non vide"}
  validates_presence_of :locality, :message => "Veuillez indiquer une localité pour le sondage"

  before_create :generate_hash_url

  def generate_hash_url
      self.hash_url = loop do
        random_hash = SecureRandom.urlsafe_base64
        break random_hash unless Survey.where(hash_url: random_hash).exists?
      end
  end
end
