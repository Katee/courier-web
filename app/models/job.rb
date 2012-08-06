class Job < ActiveRecord::Base
  attr_accessible :notes, :user

  belongs_to :client
  belongs_to :user
  has_many :drops
end
