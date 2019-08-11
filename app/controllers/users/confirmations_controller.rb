class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_confirmation_path_for(resource_name, resource)
    resource.update_mailchimp
    sign_in(resource)
    super
  end
end
