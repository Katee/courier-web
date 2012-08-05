class Client < ActiveRecord::Base
  attr_accessible :name, :notes

  has_many :jobs
end
