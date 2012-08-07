class Job < ActiveRecord::Base
  attr_accessible :notes, :user, :client_id, :user_id

  belongs_to :client
  belongs_to :user
  has_many :drops

  validates :client_id, :presence => true
end
