desc 'Pings eventbright to find out who has bought tickets'
task tickets_bought: :environment do
  event = Event.first
  eventbrite = EventbriteEvent.new(event.eventbrite_token, event.eventbrite_id)
  discount_codes = eventbrite.fetch_all_discounts
  User.find_each do |user|
    discount_code = discount_codes.find { |discount_code_json| discount_code_json['code'] == user.membership_number }
    if discount_code.present?
      user.update(ticket_bought: discount_code['quantity_sold'].positive?)
      p "#{user.email}: #{user.ticket_bought}"
    else
      p "could not find code #{user.membership_number}"
    end
  end
end
