class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_only!
    redirect_to "/", flash: { error: 'Only administrators can access this page.' } unless current_user.admin
  end
end
