class Job < ActiveRecord::Base
  attr_accessible :notes, :user, :client_id, :user_id, :drops

  belongs_to :client
  belongs_to :user
  has_many :drops

  validates :client_id, :presence => true

  def initialize(attributes={})
    super({
      :drops => [ Drop.new, Drop.new ],
    }.merge(attributes))
  end
end
