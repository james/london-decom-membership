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
  end
end
