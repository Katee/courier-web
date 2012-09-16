class LocationsController < InheritedResources::Base
  def index
    super do |format|
      format.json do
        @locations = Location.find(:all)
        @locations = @locations.collect { |i| {:lat => i.lat, :lng => i.lng, :name => i.name, :address => i.address} }
        render json: @locations
      end
      format.html do
        @locations = Location.page(params[:page])
      end
    end
  end
end
