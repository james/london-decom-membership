require 'rails_helper'

RSpec.feature 'Volunteer Roles Admin', type: :feature do
  before do
    stub_eventbrite_event
  end

  scenario 'should list existing roles, and can create more' do
    login(admin: true)
    create(:volunteer_role, name: 'Role1')
    click_link 'Events'
    click_link 'Open'
    click_link 'Volunteer Roles'
    expect(page).to have_content('Role1')
    click_link 'Add new'
    fill_in 'Name', with: 'Role2'
    fill_in 'Brief description', with: 'Description of role'
    fill_in 'Description', with: 'Description of role but with more info'
    check 'Hidden'
    fill_in 'Priority', with: '10'
    click_button 'Create Volunteer Role'
    expect(page).to have_content('Role2')
    expect(page).to have_content('Description of role')
    expect(page).to have_content('10')
  end

  scenario 'validation prevents creating a blank role' do
    login(admin: true)
    create(:event)
    click_link 'Events'
    click_link 'Open'
    click_link 'Volunteer Roles'
    click_link 'Add new'
    click_button 'Create Volunteer Role'
    expect(page).to have_content('can\'t be blank')
  end

  scenario 'editing a role' do
    login(admin: true)
    create(:volunteer_role, name: 'Role1', description: 'First Role')
    click_link 'Events'
    click_link 'Open'
    click_link 'Volunteer Roles'
    click_link 'edit'
    fill_in 'Name', with: 'Role1 edited'
    fill_in 'Brief description', with: 'Description of role edited'
    fill_in 'Description', with: 'Description of role but with more info edited'
    check 'Hidden'
    fill_in 'Priority', with: '11'
    click_button 'Save Volunteer Role'
    expect(page).to have_content('Role1 edited')
    expect(page).to have_content('Description of role edited')
    expect(page).to have_content('Description of role but with more info edited')
    expect(page).to have_content('11')
  end

  scenario 'deleting a role' do
    login(admin: true)
    create(:volunteer_role, name: 'Role1', description: 'First Role')
    click_link 'Events'
    click_link 'Open'
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
