class Location < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name, :postal, :state, :lat, :lng
  has_many :drops

  before_create :geocode

  def initialize(attributes={})
    super({
      :city => "Toronto",
      :state => "Ontario",
      :country => "Canada"
    }.merge(attributes))
  end

  # Geocode an address with geocoder.ca, costs 1/4 a cent per successful request
  def geocode
    return if address.nil?
    return if not lat.nil? and not lng.nil?
    url = "http://geocoder.ca/?locate=#{CGI.escape [address, postal, state, city, country].join(',')}&geoit=xml&jsonp=1&callback=?"
    # get the response and cut off the jsonp
    response = Curl.get(url).body_str.from(2).to(-3)
    json = JSON.parse response
    self.lng = json["longt"]
    self.lat = json["latt"]
  end
end
