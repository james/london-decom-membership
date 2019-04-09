class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :volunteer_role

  validates :accept_code_of_conduct, acceptance: true
  validates :accept_health_and_safety, acceptance: true
  validates :volunteer_role_id, uniqueness: { scope: :user_id }
  validates :state, inclusion: { in: %w[new contacted confirmed] }

  def next_state
    case state
    when 'new'
      'contacted'
    when 'contacted'
      'confirmed'
    end
  end
end
