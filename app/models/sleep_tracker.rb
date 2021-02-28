class SleepTracker < ApplicationRecord
  ZERO_TIME = '00:00:00'.freeze

  attribute :clocked_in, :clock_time, default: -> { Time.current }
  attribute :clocked_out, :clock_time

  validate :clocked_in_cannot_be_greater_than_clocked_out

  def sleeping_time
    return ZERO_TIME if clocked_out.nil? || clocked_out == clocked_in

    clocked_out - clocked_in
  end

  private

  def clocked_in_cannot_be_greater_than_clocked_out
    errors.add(:clocked_out, "can't be in the past") if clocked_out.present? && clocked_in > clocked_out
  end
end
