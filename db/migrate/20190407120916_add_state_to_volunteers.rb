class AddStateToVolunteers < ActiveRecord::Migration[5.2]
  def change
    add_column :volunteers, :state, :string, default: 'new'
  end
end
