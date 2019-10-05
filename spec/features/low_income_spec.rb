require 'rails_helper'

RSpec.feature 'Low Income', type: :feature do
  scenario 'user has 2 available tickets and bought 2' do
    stub_eventbrite_event(available_tickets_for_code: 0, tickets_sold_for_code: 2)
    create(:event)
    login

    expect(page).to_not have_text('Apply for low income')
  end

  scenario 'user has 1 available tickets and bought none' do
    pending 'Applications have now closed'
    stub_eventbrite_event(available_tickets_for_code: 1, tickets_sold_for_code: 0)
    create(:event)
    login

    click_link 'Apply for low income'
    fill_in 'Please let us know why you believe you need a low income ticket', with: 'My reason'
    click_button 'Submit request'

    expect(page).to_not have_text('Apply for low income')
    expect(page).to have_text('You have applied for Low Income Tickets.')
    expect(page.html).to include(User.last.membership_code.code)

    LowIncomeRequest.last.approve!

    visit root_path

    expect(page).to have_text('Your request for Low Income has been approved.')
    expect(page.html).to include(LowIncomeRequest.last.low_income_code.code)
    expect(page.html).to_not include(User.last.membership_code.code)

    LowIncomeRequest.last.reject!

    visit root_path

    expect(page).to have_text('Your request for Low Income has been rejected.')
    expect(page.html).to include(User.last.membership_code.code)
  end
end
