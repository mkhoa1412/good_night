class SleepTracking < ApplicationRecord
  validates_presence_of :sleep_time, :wake_up_time
  validate :validate_sleep_duration

  before_save :calculate_sleep_duration

  belongs_to :user

  def self.clock_in_operation
    SleepTracking.where.not(wake_up_time: nil).order(created_at: :desc)
  end

  private

  def calculate_sleep_duration
    self.sleep_duration = (wake_up_time - sleep_time).to_i
  end
  
  def validate_sleep_duration
    if sleep_time.present? && wake_up_time.present? && sleep_time >= wake_up_time
      errors.add(:sleep_time, "must be before wake up time")
    end
  end
end
