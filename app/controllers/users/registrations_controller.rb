class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

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

  protected

  def after_inactive_sign_up_path_for(_resource)
    confirmation_notice_path
  end
end
