class LocationUpdate < ActiveRecord::Base
  belongs_to :user
  attr_accessible :at, :lat, :lng, :courier_id

  def summary
    {
      :lat => lat,
      :lng => lng
    }
  end
end
