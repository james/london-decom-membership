class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :last_sign_in_ip, :current_sign_in_ip

  validates :name, presence: true
  validates :accept_principles, acceptance: true
  validates :accept_emails, acceptance: true
  validates :accept_no_ticket, acceptance: true
  validates :accept_code_of_conduct, acceptance: true
  validates :accept_health_and_safety, acceptance: true
  validates :membership_code, presence: true

  before_validation :set_membership_code, on: :create

  has_one :membership_code, dependent: :destroy
  has_many :volunteers, dependent: :destroy

  scope :confirmed, -> { where('confirmed_at IS NOT NULL') }

  def membership_number
    membership_code.code
  end

  def lead_for?(volunteer_role)
    volunteers.where(volunteer_role: volunteer_role, lead: true).present?
  end

  def email_hash
    Digest::MD5.hexdigest(email)
  end

  def update_mailchimp
    return if ENV['MAILCHIMP_TOKEN'].blank?

    gibbon.lists(list_id).members(email_hash).upsert(
      body: {
        email_address: email,
        status: 'subscribed',
        merge_fields: { NAME: name }
      }
    )
    gibbon.lists(list_id).members(email_hash).tags.create(
      body: {
        tags: [
          { name: 'member', status: 'active' },
          { name: 'member-marketing', status: (marketing_opt_in ? 'active' : 'inactive') }
        ]
      }
    )
  end

  private

  def set_membership_code
    self.membership_code = MembershipCode.available.first || MembershipCode.create!
  end

  def gibbon
    @gibbon ||= Gibbon::Request.new(api_key: ENV['MAILCHIMP_TOKEN'])
  end

  def list_id
    @list_id ||= gibbon.lists.retrieve.body['lists'].first['id']
  end
end
