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

    visit event_path(role.event)
    expect(page).to have_content('You are a lead for this role')
    click_link 'view volunteers'
    expect(page).to have_content(volunteer1.email)
    expect(page).to have_content(volunteer2.email)
    expect(page).to_not have_content(not_a_volunteer.email)
  end

  scenario 'marking volunteers as contacted and confirmed' do
    stub_eventbrite_event
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    create(:volunteer, volunteer_role: role, user: @user, lead: true)

    visit event_volunteer_role_volunteers_path(role.event, role)
    expect(page).to have_content('new')
    click_button 'Mark as contacted'
    expect(page).to have_content('contacted')
    click_button 'Mark as confirmed'
    expect(page).to have_content('confirmed')
  end

  scenario 'removing a volunteer' do
    stub_eventbrite_event
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    create(:volunteer, volunteer_role: role, user: @user, lead: true)
    volunteer1 = create(:volunteer, volunteer_role: role).user

    visit event_volunteer_role_volunteers_path(role.event, role)
    page.all('input[value="remove"]')[1].click
    expect(page).to have_content("#{volunteer1.name} has been removed as a volunteer")
    expect(page).to_not have_content(volunteer1.email)
  end

  scenario 'viewing the volunteers when not a lead' do
    stub_eventbrite_event
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    create(:volunteer, volunteer_role: role, user: @user, lead: false)
    visit event_path(role.event)
    expect(page).to_not have_content('You are a lead for this role')
    visit event_volunteer_role_volunteers_path(role.event, role)
    expect(page).to have_text('You are not permitted to view this')
  end
end
