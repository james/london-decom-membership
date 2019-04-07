require 'rails_helper'

RSpec.feature 'Volunteering', type: :feature do
  scenario 'signing up to volunteer successfully' do
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    lead = create(:volunteer, volunteer_role: role, lead: true).user
    stub_eventbrite_event
    login

    expect(page).to have_text('Ranger')
    expect(page).to have_text('A description of rangering')
    click_link 'Ranger'
    check 'I agree to the Decom Code of Conduct'
    check "I confirm that I've read the Decom Health and Safety Guidelines"
    click_button 'Volunteer'
    expect(page).to have_text("You've signed up to volunteer for")
    expect(@user.volunteers.count).to eq(1)

    open_email(lead.email)
    expect(current_email).to have_content('James Darling just volunteered for Ranger')

    expect(page).to have_text('The leads for this role should be in contact with you very soon')
    volunteer = @user.volunteers.last
    volunteer.update(state: 'contacted')
    visit root_path
    expect(page).to have_text('You have been contacted by a lead')
    volunteer.update(state: 'confirmed')
    visit root_path
    expect(page).to have_text('You are confirmed as a volunteer')
  end

  scenario 'cancelling a volunteering' do
    volunteer_role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    stub_eventbrite_event
    login
    create(:volunteer, user: @user, volunteer_role: volunteer_role)

    visit root_path
    click_link 'cancel'
    expect(page).to have_content('You are no longer volunteering for Ranger')
    expect(@user.volunteers.count).to eq(0)
  end
end
