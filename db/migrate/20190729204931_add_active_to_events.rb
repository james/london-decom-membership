class AddActiveToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :active, :boolean, null: false, default: false
  end
end
