class HomeController < ApplicationController
  layout "map"

  def index
    respond_to do |format|
      format.html do
        puts current_user
        puts current_user.nil?
        if not current_user.nil?
          render action: "map"
        end
      end
    end
  end

  def map
  end
end
