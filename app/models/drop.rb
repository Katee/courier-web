class Drop < ActiveRecord::Base
  belongs_to :job
  has_one :location

  attr_accessible :authorized_by, :authorized_on, :job_id, :location_id

  def location
    Location.find location_id
  end
end
