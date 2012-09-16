class Client < ActiveRecord::Base
  attr_accessible :name, :notes

  has_many :jobs

  validates :name, :presence => true
  
  acts_as_ferret :fields => [ :name ]
end
