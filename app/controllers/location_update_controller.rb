class LocationUpdateController < ApplicationController
  def index
    @locations = LocationUpdate.find(:all).group_by(&:courier_id)
    
    respond_to do |format|
      format.json do
        render json: @locations
      end
    end
  end
end
