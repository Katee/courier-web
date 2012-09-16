class ClientsController < InheritedResources::Base
  def index
    super do |format|
      format.html do
        if params[:q].blank?
          @clients = Client.page(params[:page])
        else
          @clients = Client.find_with_ferret(params[:q], :page => params[:page], :per_page => WillPaginate.per_page)
        end
      end
    end
  end
end
