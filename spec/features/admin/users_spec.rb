require 'rails_helper'

RSpec.feature 'Users Admin', type: :feature do
  scenario 'should list all member email addresses' do
    stub_eventbrite_event
    login(admin: true)
    create(:user, email: 'test_mail_user@example.com')
    click_link 'Users'
    expect(page).to have_text('test_mail_user@example.com')
  end

  scenario 'can give user direct access' do
    stub_eventbrite_event
    login(admin: true)
    user = create(:user, email: 'test_mail_user@example.com')
    direct_sale_code = create(:direct_sale_code)
    click_link 'Users'
    find_all("a[text()='Edit']").last.click
    click_button 'Give direct access'
    expect(page).to have_content('Has direct sale')
    expect(user.membership_number).to eq(direct_sale_code.code)
  end

  scenario 'as not an admin' do
    stub_eventbrite_event
    login(admin: false)
    expect(page).to_not have_link('Users')
    visit admin_membership_codes_path
    expect(page).to have_text('You are not permitted to view this')
  end
end
