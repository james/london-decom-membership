require 'rails_helper'

RSpec.feature 'Users Admin', type: :feature do
  scenario 'should list all member email addresses' do
    stub_eventbrite_event
    login(admin: true)
    create(:user, email: 'test_mail_user@example.com')
    click_link 'Users'
    expect(page).to have_text('test_mail_user@example.com')
  end

  scenario 'as not an admin' do
    stub_eventbrite_event
    login(admin: false)
    expect(page).to_not have_link('Users')
    visit admin_membership_codes_path
    expect(page).to have_text('You are not permitted to view this')
  end
end
