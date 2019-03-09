require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates a new code if one doesn't exist and assigns an available code if one exists" do
    MembershipCode.destroy_all
    other_user = create(:user)
    other_membership_code = other_user.membership_code

    expect(other_membership_code).to be_a(MembershipCode)

    membership_code = create(:membership_code)
    new_user = create(:user)
    expect(new_user.membership_code).to eq(membership_code)
  end
end
