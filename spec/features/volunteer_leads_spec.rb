require 'rails_helper'

RSpec.feature 'Volunteering leads', type: :feature do
  scenario 'viewing the volunteers for their role' do
    stub_eventbrite_event
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    volunteer1 = create(:volunteer, volunteer_role: role).user
    volunteer2 = create(:volunteer, volunteer_role: role).user
    not_a_volunteer = create(:user)
    create(:volunteer, volunteer_role: role, user: @user, lead: true)

    visit root_path
    expect(page).to have_content('You are a lead for this role')
    click_link 'view volunteers'
    expect(page).to have_content(volunteer1.email)
    expect(page).to have_content(volunteer2.email)
    expect(page).to_not have_content(not_a_volunteer.email)
  end

  scenario 'viewing the volunteers when not a lead' do
    stub_eventbrite_event
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    create(:volunteer, volunteer_role: role, user: @user, lead: false)
    visit root_path
    expect(page).to_not have_content('You are a lead for this role')
    visit volunteer_role_volunteers_path(role)
    expect(page).to have_text('You are not permitted to view this')
  end
end
