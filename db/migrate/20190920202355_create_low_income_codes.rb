class CreateLowIncomeCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :low_income_codes do |t|
      t.string :code
      t.references :low_income_request, foreign_key: true

      t.timestamps
    end
  end
end
