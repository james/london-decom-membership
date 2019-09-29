class Admin::UsersController < AdminController
  def index
    if params[:q]
      q = "%#{params[:q]}%"
      @users = User.confirmed.where('name ILIKE ? OR email ILIKE ?', q, q).order(:created_at).page params[:page]
    else
      @users = User.confirmed.order(:created_at).page params[:page]
    end
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
