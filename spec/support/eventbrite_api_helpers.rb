def stub_eventbrite_event(opts = {})
  event = double(:event, { id: 1234, 'live?': false }.merge(opts))
  allow(Event).to receive(:new).and_return(event)
  event
end
