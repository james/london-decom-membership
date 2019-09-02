class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[
        name
        accept_principles
        marketing_opt_in
        accept_emails
        accept_no_ticket
        accept_code_of_conduct
        accept_health_and_safety
      ]
    )
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
