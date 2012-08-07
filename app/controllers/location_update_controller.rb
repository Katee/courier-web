class LocationUpdateController < ApplicationController
  def index
    @locations = LocationUpdate.find(:all).group_by(&:courier_id).collect do |courier_id, location_updates|
      location_updates.collect { |i| {:lat => i.lat, :lng => i.lng} }
    end
    
    respond_to do |format|
      format.json do
        render json: @locations
      end
    end
  end
end
