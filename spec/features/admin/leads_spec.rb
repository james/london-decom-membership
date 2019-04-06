require 'rails_helper'

RSpec.feature 'Volunteer Roles Admin', type: :feature do
  before do
    stub_eventbrite_event
  end
  scenario 'assigning a leader when they are not a volunteer' do
    login(admin: true)
    create(:user, email: 'lead@example.com', name: 'New Lead')
    role = create(:volunteer_role, name: 'Role1')
    click_link 'Volunteer Roles'
    click_link '0 leads'
    select 'New Lead (lead@example.com)', from: 'Find member to make a lead'
    click_button 'Make Lead'
    expect(page).to have_content('New Lead added as a lead to Role1')
    expect(role.volunteers.count).to eq(1)
    expect(role.leads.count).to eq(1)
  end

  scenario 'assigning a leader when they are already a volunteer' do
    login(admin: true)
    user = create(:user, email: 'lead@example.com', name: 'New Lead')
    role = create(:volunteer_role, name: 'Role1')
    create(:volunteer, user: user, volunteer_role: role)
    click_link 'Volunteer Roles'
    click_link '0 leads'
    select 'New Lead (lead@example.com)', from: 'Find member to make a lead'
    click_button 'Make Lead'
    expect(page).to have_content('New Lead added as a lead to Role1')
    expect(role.volunteers.count).to eq(1)
    expect(role.leads.count).to eq(1)
  end

  scenario 'removing a leader' do
    login(admin: true)
    user = create(:user, email: 'lead@example.com', name: 'New Lead')
    role = create(:volunteer_role, name: 'Role1')
    create(:volunteer, user: user, volunteer_role: role, lead: true)
    click_link 'Volunteer Roles'
    click_link '1 lead'
    click_link 'remove'
    expect(page).to have_content('New Lead has been removed as a lead to Role1')
    expect(role.volunteers.count).to eq(1)
    expect(role.leads.count).to eq(0)
  end
end
