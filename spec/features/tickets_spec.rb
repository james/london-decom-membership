require 'rails_helper'

RSpec.feature 'Tickets', type: :feature do
  scenario 'there is no active event' do
    login
    create(:event, active: false)

    expect(page).to have_text('Tickets and volunteering are not live yet')
  end

  scenario 'there is no active event, but the member has early access' do
    pending 'deactivated for the year'
    stub_eventbrite_event(available_tickets_for_code: 2, tickets_sold_for_code: 0)
    create(:event, active: false)
    login(early_access: true)

    expect(page).to have_text('Buy Tickets')
    expect(page).to have_text('You can buy 2 tickets')
  end

  scenario 'user has 2 available tickets and bought none' do
    pending 'deactivated for the year'
    stub_eventbrite_event(available_tickets_for_code: 2, tickets_sold_for_code: 0)
    create(:event)
    login

    expect(page).to have_text('Buy Tickets')
    expect(page).to have_text('You can buy 2 tickets')
  end

  scenario 'user has 2 available tickets and bought 1' do
    pending 'deactivated for the year'
    stub_eventbrite_event(available_tickets_for_code: 1, tickets_sold_for_code: 1)
    create(:event)
    login

    expect(page).to have_text('Buy Ticket')
    expect(page).to have_text('You have already bought 1 ticket. You can buy 1 more ticket')
  end

  scenario 'user has 2 available tickets and bought 2' do
    stub_eventbrite_event(available_tickets_for_code: 0, tickets_sold_for_code: 2)
    create(:event)
    login

    expect(page).to_not have_text('Buy Tickets')
    expect(page).to have_text('You have bought the 2 tickets available to you')
  end
end
