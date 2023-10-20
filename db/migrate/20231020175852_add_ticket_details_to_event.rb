class AddTicketDetailsToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :ticket_price_info, :text
    add_column :events, :ticket_information, :text
  end
end
