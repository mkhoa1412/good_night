
class SleepTrackingRepository
  def initialize(user)
    @user = user
  end

  def add_sleep_tracking(sleep_tracking)
    @user.sleep_trackings << sleep_tracking
    @user.save!
  end
end
