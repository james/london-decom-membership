require 'rails_helper'

RSpec.feature 'Low Income Requests Admin', type: :feature do
  scenario 'should list requests, and can be approved' do
    low_income_request = create(:low_income_request, request_reason: 'Reason 1')

    stub_eventbrite_event
    # A used membership code is generated when we create this admin user
    login(admin: true)
    visit admin_low_income_requests_path
    expect(page).to have_text('Reason 1')
    expect(page).to have_text(low_income_request.user.name)
    click_button 'Approve'
    expect(page).to have_text('Approved')

    open_email(low_income_request.user.email)
    expect(current_email).to have_content("Hi #{low_income_request.user.name}")
    expect(current_email).to have_content('Your request for low income tickets has been approved')
  end

  scenario 'can be rejected' do
    low_income_request = create(:low_income_request, request_reason: 'Reason 1')

    stub_eventbrite_event
    # A used membership code is generated when we create this admin user
    login(admin: true)
    visit admin_low_income_requests_path
    expect(page).to have_text('Reason 1')
    expect(page).to have_text(low_income_request.user.name)
    click_button 'Reject'
    expect(page).to have_text('Rejected')

    open_email(low_income_request.user.email)
    expect(current_email).to have_content("Hi #{low_income_request.user.name}")
    expect(current_email).to have_content('Your request for low income tickets has been rejected')
  end

  scenario 'as not an admin' do
    stub_eventbrite_event
    login(admin: false)
    visit admin_low_income_codes_path
    expect(page).to have_text('You are not permitted to view this')
  end
end
