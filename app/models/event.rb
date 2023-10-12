class Event < ApplicationRecord
  has_many :volunteer_roles, dependent: :destroy
  validates :name, presence: true
  validates :eventbrite_token, presence: true
  validates :eventbrite_id, presence: true

  enum event_mode: [:draft, :prerelease, :live, :ended]

  def self.active(early_access: false)
    if early_access
      order('created_at DESC').first
    else
      where(active: true).first
    end
  end

  def eventbrite_event
    @eventbrite_event ||= EventbriteEvent.new(eventbrite_token, eventbrite_id)
  end
  delegate :available_tickets_for_code, :tickets_sold_for_code, to: :eventbrite_event
end
