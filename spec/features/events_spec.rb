require 'rails_helper'

RSpec.feature 'Event', type: :feature do
  scenario 'there is no active event' do
    create(:event, active: false)
    login

    expect(page).to have_text('Tickets and volunteering are not live yet')
  end

  scenario 'is active but in draft mode' do
    stub_eventbrite_event(available_tickets_for_code: 0, tickets_sold_for_code: 0)
    create(:event, :draft)
    login

    expect(page).to have_text('Hey James Darling')
    expect(page).to have_text('Tickets and volunteering are not live yet')
  end

  scenario 'is active but in pre-release' do
    stub_eventbrite_event(available_tickets_for_code: 0, tickets_sold_for_code: 0)
    create(:event, :prerelease)
    login

    expect(page).to have_text('Tickets for our next event will be available to buy here soon')
    expect(page).to have_text('Here is the crucial info')
  end

  scenario 'is active but in pre-release and with ticket date' do
    stub_eventbrite_event(available_tickets_for_code: 0, tickets_sold_for_code: 0)
    create(:event, :prerelease, ticket_sale_start_date: '2023-10-22 12:00:00.000000000 +0000')
    login

    expect(page).to have_text(
      'Tickets for our next event will be available to buy here on 22/10/2023 at 12:00:00 PM (GMT).'
    )
    expect(page).to have_text('Here is the crucial info')
  end

  scenario 'is active but in live' do
    stub_eventbrite_event(available_tickets_for_code: 0, tickets_sold_for_code: 0)
    create(:event, :live)
    login

    expect(page).to_not have_text('Tickets for our next event will be available to buy here on')
    expect(page).to have_text('Here is the crucial info')
  end

  scenario 'has ended' do
    stub_eventbrite_event(available_tickets_for_code: 0, tickets_sold_for_code: 0)
    create(:event, :ended)
    login

    expect(page).to have_text('Love and Dusty Hugs')
  end
end
