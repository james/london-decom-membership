require 'rails_helper'

RSpec.feature 'Volunteering', type: :feature do
  scenario "don't have a ticket yet" do
    stub_eventbrite_event(tickets_sold_for_code: 0)
    create(:event)
    login
    expect(page).to_not have_text('Volunteer opportunities')
  end

  scenario 'signing up to volunteer successfully' do
    role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    lead = create(:volunteer, volunteer_role: role, lead: true).user
    stub_eventbrite_event(tickets_sold_for_code: 1)
    login

    click_link 'Volunteering'
    expect(page).to have_text('Ranger')
    click_link 'Volunteer'
    expect(page).to have_text('A description of rangering')
    fill_in 'Phone', with: '07777777'
    fill_in 'Additional comments', with: 'some addition comments'
    check 'I agree to the Decom Code of Conduct'
    check "I confirm that I've read the Decom Health and Safety Guidelines"
    click_button 'Volunteer'
    expect(page).to have_text("You've signed up to volunteer for")
    expect(@user.volunteers.count).to eq(1)
    expect(@user.volunteers.first.phone).to eq('07777777')
    expect(@user.volunteers.first.additional_comments).to eq('some addition comments')

    open_email(lead.email)
    expect(current_email).to have_content('James Darling just volunteered for Ranger')

    expect(page).to have_text('The leads for this role should be in contact with you very soon')
    volunteer = @user.volunteers.last
    volunteer.update(state: 'contacted')
    visit event_volunteering_index_path(:event)
    expect(page).to have_text('You have been contacted by a lead')
    volunteer.update(state: 'confirmed')
    visit event_volunteering_index_path(:event)
    expect(page).to have_text('You are confirmed as a volunteer')
  end

  scenario 'cancelling a volunteering' do
    volunteer_role = create(:volunteer_role, name: 'Ranger', description: 'A description of rangering')
    lead = create(:volunteer, volunteer_role:, lead: true).user
    stub_eventbrite_event(tickets_sold_for_code: 1)
    login
    create(:volunteer, user: @user, volunteer_role:)

    click_link 'Volunteering'
    click_link 'Un-Volunteer'
    expect(page).to have_content('You are no longer volunteering for Ranger')
    expect(@user.volunteers.count).to eq(0)

    open_email(lead.email)
    expect(current_email).to have_content('James Darling has cancelled their volunteering')
  end
end
