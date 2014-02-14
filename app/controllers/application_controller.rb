class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def admin_only!
    redirect_to "/", flash: { error: 'Only administrators can access this page.' } unless current_user.admin
  end

  def instructor_only!
    redirect_to "/", flash: { error: 'Only instructors can access this page.' } unless current_user.teaching?(@course)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :title
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :phone
    devise_parameter_sanitizer.for(:sign_up) << :wants_to_be_instructor
    devise_parameter_sanitizer.for(:sign_up) << :school_id
  end
end
