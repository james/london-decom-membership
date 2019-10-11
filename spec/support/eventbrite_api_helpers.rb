def stub_eventbrite_event(opts = {})
  event = double(
    :event,
    {
      id: 1234,
      available_tickets_for_code: 2,
      tickets_sold_for_code: 0,
      ticket_class_for_discount_code: 'aaa',
      sold_out_for_ticket_class?: false
    }.merge(opts)
  )
  allow(EventbriteEvent).to receive(:new).and_return(event)
  event
end
