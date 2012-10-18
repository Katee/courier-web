ActiveAdmin.setup do |config|
  config.site_title = "FTL Courier"

  config.authentication_method = :authenticate_admin!
  def authenticate_admin!
     redirect_to new_user_session_path unless not current_user.nil? and current_user.has_role? :admin
  end

  config.current_user_method = :current_user

  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete

  config.allow_comments = true

  config.batch_actions = true
end
