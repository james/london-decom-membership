class VolunteerRole < ApplicationRecord
  has_many :volunteers, dependent: :destroy
  scope :available_for_user, ->(user) { where.not(id: user.volunteers.pluck(:volunteer_role_id)) }
end
