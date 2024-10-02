class LowIncomeRequestWindow < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :low_income_requests_start, :datetime
    add_column :events, :low_income_requests_end, :datetime
  end
end
