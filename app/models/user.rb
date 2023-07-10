class User < ApplicationRecord

  has_many :sleep_trackings

  def sleep
    sleep_tracker.sleep
  end

  def wake_up
    sleep_tracker.wake_up
  end

  private

  def sleep_tracker
    sleep_tracker ||= SleepTracker.new(sleep_tracking_repository)
  end

  def sleep_tracking_repository
    @sleep_tracking_repository ||= SleepTrackingRepository.new(self)
  end
end
