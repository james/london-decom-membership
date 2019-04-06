class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :volunteer_role

  validates :accept_code_of_conduct, acceptance: true
  validates :accept_health_and_safety, acceptance: true
end
