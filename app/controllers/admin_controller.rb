class AdminController < ApplicationController
  before_action :authenticate_admin!

  protected

  def authenticate_admin!
    return true if current_user&.admin?

    render plain: 'You are not permitted to view this'
    false
  end
end
