def stub_eventbrite_event(opts = {})
  event = double(
    :event,
    {
      id: 1234,
      'live?': false,
      available_tickets_for_code: 2,
      tickets_sold_for_code: 0
    }.merge(opts)
  )
  allow(EventbriteEvent).to receive(:new).and_return(event)
  event
end
