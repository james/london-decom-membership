require 'rails_helper'

RSpec.feature 'Volunteer Roles Admin', type: :feature do
  before do
    stub_eventbrite_event
  end

  scenario 'should list existing codes, and can create more' do
    login(admin: true)
    create(:volunteer_role, name: 'Role1')
    click_link 'Events'
    click_link 'London Decompression 2019'
    click_link 'Volunteer Roles'
    expect(page).to have_content('Role1')
    click_link 'Add new'
    fill_in 'Name', with: 'Role2'
    fill_in 'Description', with: 'Description of role'
    click_button 'Create Volunteer Role'
    expect(page).to have_content('Role2')
    expect(page).to have_content('Description of role')
  end

  scenario 'editing a role' do
    login(admin: true)
    create(:volunteer_role, name: 'Role1', description: 'First Role')
    click_link 'Events'
    click_link 'London Decompression 2019'
    click_link 'Volunteer Roles'
    click_link 'edit'
    fill_in 'Name', with: 'Role1 edited'
    fill_in 'Description', with: 'Description of role edited'
    click_button 'Save Volunteer Role'
    expect(page).to have_content('Role1 edited')
    expect(page).to have_content('Description of role edited')
  end

  scenario 'deleting a role' do
    login(admin: true)
    create(:volunteer_role, name: 'Role1', description: 'First Role')
    click_link 'Events'
    click_link 'London Decompression 2019'
    click_link 'Volunteer Roles'
    click_button 'destroy'
    expect(page).to_not have_content('Role1')
  end

  scenario 'as not an admin' do
    stub_eventbrite_event
    event = create(:event)
    login(admin: false)
    expect(page).to_not have_link('Roles')
    visit admin_event_volunteer_roles_path(event)
    expect(page).to have_text('You are not permitted to view this')
  end
end
