class SleepTracker < ApplicationRecord
  attribute :clocked_in, :clock_time, default: -> {Time.current}
  attribute :clocked_out, :clock_time

  def sleeping_time
    duration =  if clocked_out.present?
      clocked_out - clocked_in
    else
      0
    end
    "#{duration} hours"
  end
end
