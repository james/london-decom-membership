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
end
