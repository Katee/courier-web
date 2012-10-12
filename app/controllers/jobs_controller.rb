class JobsController < InheritedResources::Base
  layout :layout

  def layout
    (["show", "index"].include? action_name) ? "nocontainer" : "application"
  end

  def index
    super do |format|
      format.json do
        locations = {}
        render json: {
          :jobs => Job.find(:all, :include => [:drops, {drops: :location}]).collect(&:summary),
          :locations => locations
        }
      end
    end
  end

  def new
    super do |format|
      format.html {
        2.times { @job.drops.build }
      }
    end
  end

  def summary
    if params.include? :id then
      render json: Job.find(params[:id], :include => [:client, :drops, {drops: :location}]).courier_summary
    else
      render json: Job.find(:all, :include => [:client, :drops, {drops: :location}]).collect(&:courier_summary)
    end
  end

  def create
    @job = Job.new params[:job]
    @job.client_id = current_user.client_id if params[:job][:client_id].nil?
    create!
  end

  def cancel
    #TODO cancel job, send email
  end
end
