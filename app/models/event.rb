class Event < ApplicationRecord
  has_many :volunteer_roles, dependent: :destroy
  validates :name, presence: true
  validates :low_income_requests_start, presence: true, if: -> { low_income_requests_end.present? }
  validates :low_income_requests_end,
            presence: true,
            comparison: { greater_than: :low_income_requests_start },
            if: -> { low_income_requests_start.present? }

  enum :event_mode, [:draft, :prerelease, :live, :ended]

  def self.active(early_access: false)
    if early_access
      order('created_at DESC').first
    else
      where(active: true).first
    end
  end

  def low_income_open?
    are_missing = !low_income_requests_start.present? && !low_income_requests_end.present?
    if are_missing
      false
    else
      outside_window = Time.zone.now.before?(low_income_requests_start) ||
                       Time.zone.now.after?(low_income_requests_end)
      !outside_window && event_mode == 'prerelease'
    end
  end

  def eventbrite_start_time
    Date.parse(eventbrite_event.eventbrite_event.start.local)
  end

  def eventbrite_event
    @eventbrite_event ||= EventbriteEvent.new(eventbrite_token, eventbrite_id)
  end
  delegate :available_tickets_for_code, :tickets_sold_for_code, to: :eventbrite_event
end
