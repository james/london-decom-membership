class ApplicationController < ActionController::Base
  skip_forgery_protection

  around_action :switch_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def switch_locale(&action)
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header
    locale_to_use = I18n.default_locale
    if I18n.available_locales.map(&:to_s).include?(locale)
      locale_to_use = locale
    else
      logger.warn "* Unsupported locale '#{locale}'"
    end
    logger.debug "* Locale set to '#{locale_to_use}'"
    I18n.with_locale(locale_to_use, &action)
    I18n.locale = I18n.locale
  end

  protected

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

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
