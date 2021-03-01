class SleepTracker < ApplicationRecord
  ZERO_TIME = '00:00:00'.freeze

  attribute :clocked_in, :clock_time, default: -> { Time.current }
  attribute :clocked_out, :clock_time

  validate :clocked_in_cannot_be_greater_than_clocked_out

  before_save :calculate_sleeping_time, unless: -> { clocked_out.nil? }

  scope :last_week_of, lambda { |users|
    if users.present?
      where(user_id: users).where(SleepTracker.arel_table[:clocked_in].gt(1.week.ago))
                           .order(sleeping_time: :desc)
    end
  }

  def sleeping_time_str
    format_seconds_to_string(sleeping_time)
  end

  private

  def clocked_in_cannot_be_greater_than_clocked_out
    errors.add(:clocked_out, "can't be in the past") if clocked_out.present? && clocked_in > clocked_out
  end

  def calculate_sleeping_time
    self.sleeping_time = clocked_out - clocked_in
  end

  def format_seconds_to_string(seconds_diff)
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
    seconds = seconds_diff
    format('%02d:%02d:%02d', hours, minutes, seconds)
  end
end
