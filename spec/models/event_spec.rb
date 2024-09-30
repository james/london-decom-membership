require 'rails_helper'

RSpec.describe Event, type: :model do
  scenario 'trying to set low income start after end' do
    event = create(:event)
    event.low_income_requests_end = Time.zone.now
    event.low_income_requests_start = Time.zone.now.advance(weeks: 1)
    expect(event).to_not be_valid
  end

  scenario 'trying to set low income end before start' do
    event = create(:event)
    event.low_income_requests_end = Time.zone.now.advance(weeks: -1)
    event.low_income_requests_start = Time.zone.now
    expect(event).to_not be_valid
  end
end
