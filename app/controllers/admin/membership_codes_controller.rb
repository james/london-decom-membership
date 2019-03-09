class Admin::MembershipCodesController < AdminController
  def index
    @membership_codes = MembershipCode.all
  end

  def create
    params[:number].to_i.times do
      MembershipCode.create!
    end
    redirect_to action: :index
  end
end
