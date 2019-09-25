class Admin::LowIncomeRequestsController < AdminController
  def index
    @low_income_requests = LowIncomeRequest.order(:created_at).page params[:page]
  end

  def approve
    @low_income_request = LowIncomeRequest.find(params[:id])
    @low_income_request.approve!
    LowIncomeMailer.approved_request(@low_income_request).deliver_now
    redirect_to action: :index
  end

  def reject
    @low_income_request = LowIncomeRequest.find(params[:id])
    @low_income_request.reject!
    LowIncomeMailer.rejected_request(@low_income_request).deliver_now
    redirect_to action: :index
  end
end
