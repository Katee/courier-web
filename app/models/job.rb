class Job < ActiveRecord::Base
  attr_accessible :notes

  belongs_to :client
  belongs_to :courier
  has_many :drops

  def client
    Client.find self.client_id
  end
end
