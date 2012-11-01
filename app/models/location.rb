class Location < ActiveRecord::Base
  has_many :drops
  belongs_to :client

  attr_accessible :address, :city, :country, :name, :postal, :state, :lat, :lng, :client_id

  before_create :geocode

  validates_presence_of :address

  def initialize(attributes={})
    super({
      :city => "Toronto",
      :state => "Ontario",
      :country => "Canada"
    }.merge(attributes))
  end

  def full_address
    [address, postal, city, country, state].reject(&:blank?).join(',')
  end

  # Geocode an address with geocoder.ca, costs 1/4 a cent per successful request
  def geocode
    # address must note be blank start with a number
    return if address.index(/[1-9]/).nil?
    return if full_address.blank?
    return if not lat.nil? and not lng.nil?
    url = "http://geocoder.ca/?locate=#{CGI.escape self.full_address}&geoit=xml&jsonp=1&auth=#{GEOCODER_CA_KEY}&callback=?"
    # get the response and cut off the jsonp
    response = Curl.get(url).body_str.from(2).to(-3)
    json = JSON.parse response
    self.lng = json["longt"]
    self.lat = json["latt"]
  end

  def summary
    {:lat => self.lat, :lng => self.lng, :name => self.name, :address => self.address, :id => self.id, :open_drop_count => Drop.where(:location_id => self.id).count}
  end
  
  def display_name
    name || address
  end
end
