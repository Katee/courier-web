class LocationUpdate < ActiveRecord::Base
  belongs_to :courier
  attr_accessible :at, :lat, :lng

  def summary
    {
      :lat => lat,
      :lng => lng
    }
  end
end
