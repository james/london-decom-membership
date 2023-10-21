class AddDetailsToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :ticket_sale_start_date, :datetime
    add_column :events, :theme, :text
    add_column :events, :theme_details, :text
    add_column :events, :theme_image_url, :text
    add_column :events, :location, :text
    add_column :events, :maps_location_url, :text
    add_column :events, :event_timings, :text
    add_column :events, :further_information, :text
    add_column :events, :event_date, :datetime
    add_column :events, :event_mode, :integer
  end
end
