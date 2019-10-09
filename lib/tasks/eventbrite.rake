desc 'Pings eventbright to find out who has bought tickets'
task tickets_bought: :environment do
  event = Event.first
  eventbrite = EventbriteEvent.new(event.eventbrite_token, event.eventbrite_id)
  eventbrite.fetch_all_discounts.each do |discount|
    membership_code = MembershipCode.find_by(code: discount['code'])
    next unless membership_code.present?

    user = membership_code.user
    if user.present?
      user.update(ticket_bought: discount['quantity_sold'].positive?)
      p "#{user.email}: #{user.ticket_bought}"
    end
  end
end
