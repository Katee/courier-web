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

  #FIXME do user auth
  def create
    respond_to do |format|
      format.json do
        # TODO authenticate courier and user their courier_id
        location = LocationUpdate.create :lat => params[:lat], :lng => params[:lng], :courier_id => 1
        location.save
        render json: "success"
      end
    end
  end
end

