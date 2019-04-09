class Event < ApplicationRecord
  has_many :volunteer_roles, dependent: :destroy

  def eventbrite_event
    EventbriteEvent.new(eventbrite_token, eventbrite_id)
  end
  delegate :'live?', :available_tickets_for_code, :tickets_sold_for_code, to: :eventbrite_event
end
