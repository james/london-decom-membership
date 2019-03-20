class EventbriteDiscountCodeNotFound < StandardError; end
class Event
  def initialize
    EventbriteSDK.token = ENV['EVENTBRITE_TOKEN']
  end

  def id
    ENV['EVENTBRIGHT_EVENT_ID']
  end

  def eventbrite_event
    @eventbrite_event ||= EventbriteSDK::Event.retrieve(id: id)
  end

  def live?
    eventbrite_event.status == 'live'
  end

  delegate :organization_id, to: :eventbrite_event

  def discount_code(code)
    return @discount_code if @discount_code

    response = HTTP.get(
      "https://www.eventbriteapi.com/v3/organizations/#{organization_id}/discounts/" \
      "?scope=event&code=#{code}&event_id=#{id}&token=#{ENV['EVENTBRITE_TOKEN']}"
    )
    discounts = JSON.parse(response)['discounts']
    raise EventbriteDiscountCodeNotFound, "Code #{code} does not exist in Eventbrite" if discounts.empty?

    @discount_code = discounts[0]
  end

  def available_tickets_for_code(code)
    discount_code(code)['quantity_available'] - tickets_sold_for_code(code)
  rescue EventbriteDiscountCodeNotFound
    0
  end

  def tickets_sold_for_code(code)
    discount_code(code)['quantity_sold']
  rescue EventbriteDiscountCodeNotFound
    0
  end
end
