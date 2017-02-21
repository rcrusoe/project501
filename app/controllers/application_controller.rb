class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys:[:first_name, :last_name, :tagline, :calendly_url, :catalant_url, :linkedin_url, :twitter_url, :medium_url, :github_url, :dribbble_url, :website_url, :avatar_url, :location, :availability, :email, :password, :current_password, :remember_me])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || user_path(resource)
  end

  def auth_user
    redirect_to new_user_registration_url unless user_signed_in?
  end

  def store_location
    session[:user_return_to] = request.fullpath
  end
end

