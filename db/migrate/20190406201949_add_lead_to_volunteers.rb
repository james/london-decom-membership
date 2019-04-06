class AddLeadToVolunteers < ActiveRecord::Migration[5.2]
  def change
    add_column :volunteers, :lead, :boolean, default: false, null: false
  end
end
