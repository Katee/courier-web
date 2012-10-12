class Job < ActiveRecord::Base
  resourcify

  attr_accessible :notes, :user, :client_id, :user_id, :drops_attributes, :pieces, :weight

  belongs_to :client
  belongs_to :user
  has_many :drops

  validates :client_id, :presence => true
  accepts_nested_attributes_for :drops, :allow_destroy => true

  def status
    if self.drops.count >= 2
      if self.drops.first.authorized_by.nil?
        return :"awaiting pickup"
      elsif self.drops.last.authorized_by.nil?
        return :"in transit"
      else
        return :completed
      end
    end
    return :processing
  end
  
  def summary
    {
      :id => self.id,
      :courier_id => self.user_id,
      :drops => self.drops.collect do |drop|
        locations[drop.location_id] = drop.location.summary
        drop.location_id
      end
    }
  end

  def courier_summary
    {
      :id => self.id,
      :courier_id => self.user_id,
      :client => self.client,
      :drops => self.drops.collect do |drop|
        drop.location.summary
      end
    }
  end
end
