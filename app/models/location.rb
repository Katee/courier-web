class Location < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name, :postal, :state, :lat, :lng
  has_many :drops

  def initialize(attributes={})
    super({
      :city => "Toronto",
      :state => "Ontario",
      :country => "Canada"
    }.merge(attributes))
  end
end
