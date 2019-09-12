class Admin::UsersController < AdminController
  def index
    @users = User.confirmed.order(:created_at).page params[:page]
  end
end
