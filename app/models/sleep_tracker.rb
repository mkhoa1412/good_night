class SleepTracker < ApplicationRecord
  attribute :clocked_in, :clock_time, default: -> {Time.current}
  attribute :clocked_out, :clock_time

  validate :clocked_in_cannot_be_greater_than_clocked_out

  def sleeping_time
    duration =  if clocked_out.blank? ||  clocked_out == clocked_in
      0
    else
      clocked_out - clocked_in
    end
    "#{duration} hours"
  end

  private 

  def clocked_in_cannot_be_greater_than_clocked_out
    if clocked_out.present? && clocked_in > clocked_out
      errors.add(:clocked_out, "can't be in the past")
    end
  end
end
