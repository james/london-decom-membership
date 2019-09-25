class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index confirmation_notice]

  def index
    if current_user
      @event = Event.active(early_access: current_user.early_access)
      @volunteer_roles = @event.volunteer_roles.available_for_user(current_user).all if @event
    else
      @user = User.new
      render :registration
    end
  end

  def confirmation_notice; end
end
