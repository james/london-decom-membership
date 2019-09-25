class Admin::UsersController < AdminController
  def index
    @users = User.confirmed.order(:created_at).page params[:page]
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to action: :index
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :early_access)
  end
end
