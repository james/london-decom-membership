require 'rails_helper'

RSpec.feature 'Tickets', type: :feature do
  scenario 'eventbrite event is not live' do
    stub_eventbrite_event('live?': false)
    login

    expect(page).to have_text('Tickets are not on sale yet')
  end

  scenario 'eventbrite event is live' do
    stub_eventbrite_event('live?': true)
    login

    expect(page).to have_text('Buy Tickets')
  end
end
