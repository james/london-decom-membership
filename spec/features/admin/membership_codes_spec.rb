require 'rails_helper'

RSpec.feature 'Membership Code Admin', type: :feature do
  scenario 'should list existing codes, and can generate more' do
    # 10 membership codes are generated in spec_helper.rb
    stub_eventbrite_event
    # A used membership code is generated when we create this admin user
    login(admin: true)
    visit admin_membership_codes_path
    expect(page).to have_text('9 available')
    expect(page).to have_text('1 codes have been assigned')
    fill_in 'number', with: '2'
    click_button 'Create'
    expect(page).to have_text('11 available')
    expect(page).to have_text('1 codes have been assigned')
  end

  scenario 'as not an admin' do
    stub_eventbrite_event
    login(admin: false)
    visit admin_membership_codes_path
    expect(page).to have_text('You are not permitted to view this')
  end
end
