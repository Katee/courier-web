class HomeController < ApplicationController
  layout "nocontainer"

  def index
    respond_to do |format|
      format.html do
        @body_classes = "map"
        if not current_user.nil? and current_user.has_role? :admin
          render action: "dispatchmap"
        elsif not current_user.nil?
          @body_classes = ""
          @jobs = Job.find(:all)
          render action: "dashboard"
        end
      end
    end
  end
  
  def members
  end
end
