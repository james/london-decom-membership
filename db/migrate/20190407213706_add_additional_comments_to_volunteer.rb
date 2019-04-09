class AddAdditionalCommentsToVolunteer < ActiveRecord::Migration[5.2]
  def change
    add_column :volunteers, :phone, :string
    add_column :volunteers, :additional_comments, :text
  end
end
