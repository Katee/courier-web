class LocationsController < InheritedResources::Base
  layout :layout

  def layout
    (["index", "search"].include? action_name) ? "nocontainer" : "application"
  end

  def index
    super do |format|
      format.json do
        @locations = Location.find(:all).collect { |l| l.summary }
        render json: @locations
      end
      format.html do
        @locations = Location.page(params[:page])
      end
    end
  end

  alias :search :index
end
