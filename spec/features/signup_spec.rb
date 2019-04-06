require 'rails_helper'

RSpec.feature 'Member signup', type: :feature do
  scenario 'successfully signup as a member' do
    stub_eventbrite_event
    visit root_path

    fill_in 'Name', with: 'James Darling'
    fill_in 'Email address', with: 'james@abscond.org'
    fill_in 'Password', with: 'password'
    check 'I am prepared'
    click_button 'Sign up'

    expect(page).to have_text('Check your email')
    open_email('james@abscond.org')
    current_email.click_link 'Confirm my account'
    expect(page).to have_text('Hello James Darling!')
  end

  scenario 'validation errors' do
    visit root_path
    click_button 'Sign up'
    expect(page).to have_text("can't be blank")
    expect(page).to have_selector('#user_accept_principles.is-invalid')
  end
end
