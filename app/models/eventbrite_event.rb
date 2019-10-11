class EventbriteDiscountCodeNotFound < StandardError; end
class EventbriteEvent
  attr_accessor :eventbrite_token, :eventbrite_id
  def initialize(eventbrite_token, eventbrite_id)
    @eventbrite_token = eventbrite_token
    @eventbrite_id = eventbrite_id
    EventbriteSDK.token = eventbrite_token
  end

  def eventbrite_event
    @eventbrite_event ||= EventbriteSDK::Event.retrieve(id: eventbrite_id)
  end

  delegate :organization_id, to: :eventbrite_event

  def fetch_all_discounts
    discounts = []
    page = 1
    finished = false
    while finished == false
      response = HTTP.get(
        "https://www.eventbriteapi.com/v3/organizations/#{organization_id}/discounts/" \
        "?scope=event&event_id=#{eventbrite_id}&token=#{eventbrite_token}&page_size=200&page=#{page}"
      )
      if JSON.parse(response)['error'] == 'BAD_PAGE'
        finished = true
      else
        discounts << JSON.parse(response)['discounts']
        page += 1
      end
    end
    discounts.flatten
  end

  def discount_code(code)
    return @discount_code if @discount_code

    response = HTTP.get(
      "https://www.eventbriteapi.com/v3/organizations/#{organization_id}/discounts/" \
      "?scope=event&code=#{code}&event_id=#{eventbrite_id}&token=#{eventbrite_token}"
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

  def ticket_class_for_discount_code(code)
    discount_code(code)['ticket_class_ids'].first
  end

  def ticket_class(id)
    @ticket_class ||= EventbriteSDK::TicketClass.retrieve(id: id, event_id: eventbrite_id)
  end

  def sold_out_for_ticket_class?(id)
    ticket_class(id).on_sale_status == 'SOLD_OUT'
  end
end
