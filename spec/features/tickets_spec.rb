require 'rails_helper'

RSpec.feature 'Tickets', type: :feature do
  scenario 'eventbrite event is not live' do
    stub_eventbrite_event('live?': false)
    login

    expect(page).to have_text('Tickets are not on sale yet')
  end

  scenario 'eventbrite event is live and user has 2 available tickets and bought none' do
    stub_eventbrite_event('live?': true, available_tickets_for_code: 2, tickets_sold_for_code: 0)
    login

    expect(page).to have_text('Buy Tickets')
    expect(page).to have_text('You can buy 2 tickets')
  end

  scenario 'eventbrite event is live and user has 2 available tickets and bought 1' do
    stub_eventbrite_event('live?': true, available_tickets_for_code: 1, tickets_sold_for_code: 1)
    login

    expect(page).to have_text('Buy Tickets')
    expect(page).to have_text('You have already bought 1 ticket. You can buy 1 more ticket')
  end

  scenario 'eventbrite event is live and user has 2 available tickets and bought none' do
    stub_eventbrite_event('live?': true, available_tickets_for_code: 0, tickets_sold_for_code: 2)
    login

    expect(page).to_not have_text('Buy Tickets')
    expect(page).to have_text('You have bought the 2 tickets available to you')
  end
end
