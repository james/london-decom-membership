class AddMarketingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :marketing_opt_in, :boolean, default: false, null: false
  end
end
