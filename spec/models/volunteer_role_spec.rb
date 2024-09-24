require 'rails_helper'

RSpec.describe VolunteerRole, type: :model do
  describe '.available_for_user' do
    let!(:user) { create(:user) }
    let!(:volunteer_role1) { create(:volunteer_role) }
    let!(:volunteer_role2) { create(:volunteer_role) }
    it 'filters out roles that a user has already signed up for' do
      create(:volunteer, user:, volunteer_role: volunteer_role1)
      expect(VolunteerRole.available_for_user(user).all).to eq([volunteer_role2])
    end

    it 'returns all if user has no volunteers' do
      expect(VolunteerRole.available_for_user(user).all).to eq([volunteer_role1, volunteer_role2])
    end
  end
end
