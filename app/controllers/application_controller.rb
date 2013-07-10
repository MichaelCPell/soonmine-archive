class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?





  def after_sign_in_path_for(resource)
    destination = stored_location_for(resource)
    if destination
      destination
    else
      current_user
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:firstname, :lastname, :email, :password, :password_confirmation) 
    end
  end

  def check_for_email
    if current_user.email.nil?
      redirect_to user_complete_email_path
    end
  end
end
