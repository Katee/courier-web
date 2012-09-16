class ClientsController < InheritedResources::Base
  def index
    super do |format|
      format.html do
        @clients = Client.page(params[:page])
      end
    end
  end
end
