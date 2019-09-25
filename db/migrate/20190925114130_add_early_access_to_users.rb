class AddEarlyAccessToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :early_access, :boolean
  end
end
