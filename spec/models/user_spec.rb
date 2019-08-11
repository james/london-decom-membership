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

  describe '#update_mailchimp' do
    around do |example|
      ClimateControl.modify MAILCHIMP_TOKEN: '12345678901234567890123456789012-us3' do
        example.run
      end
    end

    before do
      stub_request(:get, 'https://us3.api.mailchimp.com/3.0/lists').to_return(body: '{"lists":[{"id":"1234"}]}')
      @user_stub = stub_request(:put, 'https://us3.api.mailchimp.com/3.0/lists/1234/members/2585df46821f60e7ea95e8cb7f495623')
                   .with(
                     body: {
                       'email_address': 'james@abscond.org',
                       'status': 'subscribed',
                       'merge_fields': { 'NAME': 'James Darling' }
                     }
                   )
      @tag_stub = stub_request(:post, 'https://us3.api.mailchimp.com/3.0/lists/1234/members/2585df46821f60e7ea95e8cb7f495623/tags')
                  .with(
                    body: {
                      'tags': [
                        { 'name': 'member', 'status': 'active' },
                        { 'name': 'member-marketing', 'status': 'inactive' }
                      ]
                    }
                  )
    end

    it 'should create a user on Mailchimp' do
      new_user = create(:user, email: 'james@abscond.org', name: 'James Darling')
      new_user.update_mailchimp
      expect(@user_stub).to have_been_requested
    end

    it 'should create tag the user on Mailchimp' do
      new_user = create(:user, email: 'james@abscond.org', name: 'James Darling')
      new_user.update_mailchimp
      expect(@tag_stub).to have_been_requested
    end
  end
end
