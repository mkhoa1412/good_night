class SleepTracker
  attr_reader :sleep_tracking_repository, :current_sleep

  def initialize(sleep_tracking_repository)
    @sleep_tracking_repository = sleep_tracking_repository
    @current_sleep ||= SleepTracking.new
  end       

  def sleep(sleep_time = DateTime.now)
    current_sleep.sleep_time = sleep_time
    true
  end

  def wake_up(wake_up_time = DateTime.now)
    raise StandardError,  "You are not sleeping" if current_sleep.sleep_time.nil?
    
    current_sleep.wake_up_time = wake_up_time
    sleep_tracking_repository.add_sleep_tracking(current_sleep)
    true
  end
end
