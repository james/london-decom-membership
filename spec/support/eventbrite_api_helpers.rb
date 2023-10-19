def stub_eventbrite_event(opts = {})
  event = double(
    :event,
    {
      id: 1234,
      available_tickets_for_code: 2,
      tickets_sold_for_code: 0,
      eventbrite_event: double(
        :eventbrite_event,
        start: double(
          :local,
          local: '2024-09-01T22:00:00'
        )
      )
    }.merge(opts)
  )
  allow(EventbriteEvent).to receive(:new).and_return(event)
  event
end
