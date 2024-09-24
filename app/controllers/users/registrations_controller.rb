class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def check_captcha
    return if verify_recaptcha(action: 'signup')

    self.resource = resource_class.new sign_up_params
    resource.validate # Look for any other validation errors besides reCAPTCHA
    set_minimum_password_length

    respond_with_navigational(resource) do
      flash.discard(:recaptcha_error) # We need to discard flash to avoid showing it on the next page reload
      render :new
    end
  end

  def update_resource(resource, params)
    result = resource.update_with_password(params)
    resource.update_mailchimp if result
    result
  end

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

    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[
        name
        email
        password
        password_confirmation
        current_password
        marketing_opt_in
      ]
    )
  end

  def after_inactive_sign_up_path_for(_resource)
    confirmation_notice_path
  end
end
