require 'rails_helper'

RSpec.feature 'Tickets', type: :feature do
  scenario 'there is no active event' do
    login
    create(:event, active: false)

    expect(page).to have_text('Tickets and volunteering are not live yet')
  end

  scenario 'there is no active event, but the member has early access' do
    stub_eventbrite_event(available_tickets_for_code: 1, tickets_sold_for_code: 0)
    create(:event, active: false)
    login(early_access: true)

    expect(page).to have_text('Buy Ticket')
    expect(page).to have_text('You can buy 1 ticket')
  end

  scenario 'user has 1 available tickets and bought none' do
    stub_eventbrite_event(available_tickets_for_code: 1, tickets_sold_for_code: 0)
    create(:event)
    login

    expect(page).to have_text('Buy Ticket')
    expect(page).to have_text('You can buy 1 ticket')
  end

  scenario 'user has 1 available tickets and bought 1' do
    stub_eventbrite_event(available_tickets_for_code: 0, tickets_sold_for_code: 1)
    create(:event)
    login

    expect(page).to_not have_text('Buy Ticket')
    expect(page).to have_text('You have bought the 1 ticket available to you')
  end
end
