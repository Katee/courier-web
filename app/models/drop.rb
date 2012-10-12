class Drop < ActiveRecord::Base
  belongs_to :job
  belongs_to :location
  has_one :user, :through => :job

  attr_accessible :authorized_by, :authorized_on, :job_id, :location_id

  validates :location_id, :presence => true

  before_update :update_authorized_on

  def to_s
    "Drop at #{location.name}"
  end

  private
  # update authorized_on when authorized_by is updated
  def update_authorized_on
    if @changed_attributes.include? "authorized_by"
      self.authorized_on = Time.now
    end
  end
end
