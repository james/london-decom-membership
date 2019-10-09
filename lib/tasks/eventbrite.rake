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

desc 'returns emails of ticket purchasers who have not yet volunteered. Run rake tickets_bought first'
task attendees_who_have_not_volunteered: :environment do
  attendees_who_have_not_volunteered = User.where(ticket_bought: true)
                                           .includes(:volunteers)
                                           .where(volunteers: { user_id: nil })
  p attendees_who_have_not_volunteered.pluck(:email).join(',')
end

desc 'returns emails user who have low income but not used yet. Run rake tickets_bought first'
task unused_low_income: :environment do
  unused_low_income = User.where('ticket_bought IS NOT true')
                          .includes(:low_income_request)
                          .where(low_income_requests: { status: 'approved' })
  p unused_low_income.pluck(:email).join(',')
end
