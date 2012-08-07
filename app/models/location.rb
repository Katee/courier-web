class Location < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name, :postal, :state

  def initialize(attributes=nil)
    super({
      :city => "Toronto",
      :state => "Ontario",
      :country => "Canada"
    }.merge(attributes))
  end

  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :clients
end