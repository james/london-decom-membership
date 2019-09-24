class CreateLowIncomeRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :low_income_requests do |t|
      t.references :user, foreign_key: true
      t.text :request_reason
      t.string :status
      t.text :status_reason

      t.timestamps
    end
  end
end
