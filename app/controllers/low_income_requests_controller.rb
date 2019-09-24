class LowIncomeRequestsController < ApplicationController
  def new
    @low_income_request = LowIncomeRequest.new(user: current_user)
  end

  def create
    @low_income_request = LowIncomeRequest.new(low_income_request_params.merge(user: current_user))
    @low_income_request.save!
    redirect_to root_path
  end

  private

  def low_income_request_params
    params.require(:low_income_request).permit(:request_reason)
  end
end
