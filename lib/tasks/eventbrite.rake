desc 'Pings eventbright to find out who has bought tickets'
task tickets_bought: :environment do
  event = Event.first
  User.find_each do |user|
    eventbrite = EventbriteEvent.new(event.eventbrite_token, event.eventbrite_id)
    tickets_sold = eventbrite.tickets_sold_for_code(user.membership_number)
    p user.email
    if tickets_sold.positive?
      user.update(ticket_bought: true)
      p 'Sold'
    else
      p 'not sold'
    end
  end
end
