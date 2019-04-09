class AddEventsToVolunteerRoles < ActiveRecord::Migration[5.2]
  def change
    add_reference :volunteer_roles, :event, foreign_key: true
  end
end
