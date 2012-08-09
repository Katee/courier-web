class Drop < ActiveRecord::Base
  belongs_to :job
  belongs_to :location
  has_one :user, :through => :job

  attr_accessible :authorized_by, :authorized_on, :job_id, :location_id

  def to_s
    "Drop at #{location.name}"
  end
end
