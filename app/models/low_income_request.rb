class LowIncomeRequest < ApplicationRecord
  belongs_to :user
  has_one :low_income_code, dependent: :destroy

  def approve!
    update(status: 'approved')
    LowIncomeCode.available.first.update(low_income_request: self)
  end

  def reject!
    update(status: 'rejected')
  end
end
