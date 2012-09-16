class LocationsController < InheritedResources::Base
  def index
    super do |format|
      format.json do
        @locations = Location.find(:all)
        @locations = @locations.collect { |i| {:lat => i.lat, :lng => i.lng, :name => i.name, :address => i.address, :id => i.id} }
        render json: @locations
      end
      format.html do
        if params[:q].blank?
          @locations = Location.page(params[:page])
        else
          @locations = Location.find_with_ferret(params[:q], :page => params[:page], :per_page => WillPaginate.per_page)
        end
      end
    end
  end
end
