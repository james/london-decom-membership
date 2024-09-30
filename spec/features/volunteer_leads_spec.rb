require 'rails_helper'

RSpec.feature 'Volunteering leads', type: :feature do
  scenario 'viewing the volunteers for their role' do
    stub_eventbrite_event(tickets_sold_for_code: 1)
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    volunteer1 = create(:volunteer, volunteer_role: role).user
    volunteer2 = create(:volunteer, volunteer_role: role).user
    not_a_volunteer = create(:user)
    create(:volunteer, volunteer_role: role, user: @user, lead: true)

    visit root_path
    click_link 'Volunteering'
    expect(page).to have_content('As you are the lead for this role')

    click_link 'View Volunteers'
    expect(page).to have_content(volunteer1.email)
    expect(page).to have_content(volunteer2.email)
    expect(page).to_not have_content(not_a_volunteer.email)
  end

  scenario 'marking volunteers as contacted and confirmed' do
    stub_eventbrite_event(tickets_sold_for_code: 1)
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
    stub_eventbrite_event(tickets_sold_for_code: 1)
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    create(:volunteer, volunteer_role: role, user: @user, lead: true)
    volunteer1 = create(:volunteer, volunteer_role: role).user

    visit event_volunteer_role_volunteers_path(role.event, role)
    page.all('input[value="remove"]')[1].click
    expect(page).to have_content("#{volunteer1.name} has been removed as a volunteer")
    expect(page).to_not have_content(volunteer1.email)
  end

  scenario 'downloading CSV of volunteers' do
    stub_eventbrite_event(tickets_sold_for_code: 1)
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    role2 = create(:volunteer_role)
    create(:volunteer, volunteer_role: role, user: @user, lead: true)
    volunteer1 = create(:volunteer, volunteer_role: role, phone: '077777', additional_comments: 'A comment').user
    create(:volunteer, volunteer_role: role2, additional_comments: 'Another role').user

    visit event_volunteer_role_volunteers_path(role.event, role)
    click_link 'download a CSV'

    expect(page).to have_content("#{volunteer1.name},#{volunteer1.email},077777,A comment,new")
    expect(page).to_not have_content('Another role')
  end

  scenario 'viewing the volunteers when not a lead' do
    stub_eventbrite_event(tickets_sold_for_code: 1)
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    create(:volunteer, volunteer_role: role, user: @user, lead: false)
    visit root_path
    click_link 'Volunteering'
    expect(page).to_not have_content('As you are the lead for this role')
    visit event_volunteer_role_volunteers_path(role.event, role)
    expect(page).to have_text('You are not permitted to view that page')
  end

  scenario 'viewing the volunteers after removing self as lead' do
    stub_eventbrite_event(tickets_sold_for_code: 1)
    login
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    create(:volunteer, volunteer_role: role, user: @user, lead: true)

    visit root_path
    click_link 'Volunteering'
    click_link 'View Volunteers'
    click_link 'Volunteering'
    click_link 'Un-Volunteer'
    expect(page).to_not have_text("You've signed up to volunteer for:")
  end
end
