require 'rails_helper'

RSpec.feature 'Member signup', type: :feature do
  around do |example|
    ClimateControl.modify MAILCHIMP_TOKEN: '12345678901234567890123456789012-us3' do
      example.run
    end
  end

  scenario 'successfully signup as a member' do
    stub_eventbrite_event
    stub_request(:get, 'https://us3.api.mailchimp.com/3.0/lists').to_return(body: '{"lists":[{"id":"1234"}]}')
    stub_request(:put, 'https://us3.api.mailchimp.com/3.0/lists/1234/members/2585df46821f60e7ea95e8cb7f495623')
      .with(
        body: '{"email_address":"james@abscond.org","status":"subscribed","merge_fields":{"NAME":"James Darling"}}'
      )
    stub_request(:post, 'https://us3.api.mailchimp.com/3.0/lists/1234/members/2585df46821f60e7ea95e8cb7f495623/tags')
      .with(
        body: '{"tags":[{"name":"member","status":"active"},{"name":"member-marketing","status":"active"}]}'
      )
    visit root_path

    fill_in 'Name', with: 'James Darling'
    fill_in 'Email address', with: 'james@abscond.org'
    fill_in 'Password', with: 'password'
    check 'I have read and am prepared to take into consideration'
    check 'Volunteers and Participants Code of Conduct'
    check 'Health and Safety Guidelines'
    check 'I agree to receive emails from London Decompression'
    check 'I understand that being a member'
    check 'I agree to receive emails from third parties'
    click_button 'Sign up'

    expect(page).to have_text('A message with a confirmation link has been sent to your email address')
    open_email('james@abscond.org')
    current_email.click_link 'Confirm my account'
    expect(page).to have_text('Hello James Darling')
  end

  scenario 'validation errors' do
    visit root_path
    click_button 'Sign up'
    expect(page).to have_text("can't be blank")
    expect(page).to have_selector('#user_accept_principles.is-invalid')
  end
end
