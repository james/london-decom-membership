class VolunteerRole < ApplicationRecord
  belongs_to :event
  has_many :volunteers, dependent: :destroy
  scope :available_for_user, lambda { |user|
    where.not(id: user.volunteers.pluck(:volunteer_role_id))
         .order(:priority)
         .where('hidden IS NOT true')
  }

  def leads
    volunteers.where(lead: true)
  end

  def lead_emails
    leads.collect { |l| l.user.email }
  end
end
