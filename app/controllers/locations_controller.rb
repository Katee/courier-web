class LocationsController < InheritedResources::Base
  def index
    super do |format|
      format.json do
        @locations = Location.find(:all).collect { |i| {:lat => i.lat, :lng => i.lng, :name => i.name} }
        render json: @locations
      end
    end
  end
end
