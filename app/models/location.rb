class Location < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name, :postal, :state, :lat, :lng
  has_many :drops

  before_create :geocode

  acts_as_ferret :fields => [ :name, :address ]

  def initialize(attributes={})
    super({
      :city => "Toronto",
      :state => "Ontario",
      :country => "Canada"
    }.merge(attributes))
  end

  def full_address
    [address, postal, city, country, state].reject{|w|w.blank?}.join(',')
  end
  # Geocode an address with geocoder.ca, costs 1/4 a cent per successful request
  def geocode
    return if address.index(/[1-9]/).nil?
    return if full_address.nil?
    return if not lat.nil? and not lng.nil?
    url = "http://geocoder.ca/?locate=#{CGI.escape self.full_address}&geoit=xml&jsonp=1&auth=250811195292556406039x1903&callback=?"
    # get the response and cut off the jsonp
    response = Curl.get(url).body_str.from(2).to(-3)
    json = JSON.parse response
    self.lng = json["longt"]
    self.lat = json["latt"]
  end
end
