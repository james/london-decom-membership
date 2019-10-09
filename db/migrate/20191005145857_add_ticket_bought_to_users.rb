class AddTicketBoughtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ticket_bought, :boolean
  end
end
