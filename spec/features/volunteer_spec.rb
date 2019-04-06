require 'rails_helper'

RSpec.feature 'Volunteering', type: :feature do
  scenario 'signing up to volunteer successfully' do
    create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
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
  end

  scenario 'cancelling a volunteering' do
    volunteer_role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    stub_eventbrite_event
    login
    create(:volunteer, user: @user, volunteer_role: volunteer_role)

    visit root_path
    click_link 'cancel'
    expect(@user.volunteers.count).to eq(0)
  end
end
