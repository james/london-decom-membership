class AddMoreInfoToVolunteerRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :volunteer_roles, :hidden, :boolean
    add_column :volunteer_roles, :brief_description, :text
    add_column :volunteer_roles, :priority, :integer
  end
end
