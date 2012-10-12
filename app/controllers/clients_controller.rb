class ClientsController < InheritedResources::Base
  layout :layout

  def layout
    (["index"].include? action_name) ? "nocontainer" : "application"
  end

  def index
    super do |format|
      format.html do
        @clients = Client.page(params[:page])
      end
    end
  end
end
