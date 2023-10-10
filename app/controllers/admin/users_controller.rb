class Admin::UsersController < AdminController
  def index
    if params[:q]
      q = "%#{params[:q]}%"
      @users = User.confirmed.where('name ILIKE ? OR email ILIKE ?', q, q).order(:created_at).page params[:page]
    else
      @users = User.confirmed.order(:created_at).page params[:page]
    end
  end

  def unconfirmed
    @users = User.unconfirmed.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    @user.update_mailchimp
    redirect_to action: :index
  end

  def give_direct_sale
    @user = User.find(params[:id])
    direct_sale_code = DirectSaleCode.available.first
    direct_sale_code.update(user: @user)
    redirect_to edit_admin_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :early_access, :marketing_opt_in)
  end
end
