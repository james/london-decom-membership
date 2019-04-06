class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_event
    @current_event ||= Event.new
  end
  helper_method :current_event

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name accept_principles])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
