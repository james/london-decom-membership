class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index confirmation_notice]

  def index
    if current_user

    else
      @user = User.new
      render :registration
    end
  end

  def confirmation_notice; end
end
