class Location < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name, :postal, :state
end
