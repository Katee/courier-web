class Drop < ActiveRecord::Base
  belongs_to :job
  has_one :location

  attr_accessible :authorized_by, :authorized_on, :job, :location
end
