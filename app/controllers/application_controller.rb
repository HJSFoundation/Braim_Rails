class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email,:password,:name, :last_name, :country)}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email,:current_password,:password,:name, :last_name, :country, profile_attributes: [:birthday,:gender]) }
  end

  protected

  def after_sign_in_path_for(resource)
    profile_path
  end
end
