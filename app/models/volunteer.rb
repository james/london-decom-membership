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

  def self.to_csv
    require 'csv'

    CSV.generate(headers: true) do |csv|
      csv << %w[Name Email Phone Comments State]

      all.each do |v|
        csv << [v.user.name, v.user.email, v.phone, v.additional_comments, v.state]
      end
    end
  end
end
