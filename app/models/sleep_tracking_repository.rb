
class SleepTrackingRepository
  def initialize(user)
    @user = user
  end

  def add_sleep_tracking(sleep_tracking)
    @user.sleep_trackings << sleep_tracking
    @user.save!
  end

  def friend_sleep_records
    friends = @user.followed_users
    SleepTracking.where(user_id: friends.pluck(:id))
                  .where('created_at >= ?', 1.week.ago)
                  .order(sleep_duration: :desc, created_at: :desc)
  end
end
