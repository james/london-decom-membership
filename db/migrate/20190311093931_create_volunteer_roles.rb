class CreateVolunteerRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteer_roles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
