class User < ApplicationRecord
  has_many :sleep_trackings
  
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed_user

  has_many :reverse_follows, foreign_key: :followed_user_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :follower

  def follow(user)
    followed_users << user
  end

  def unfollow(user)
    followed_users.delete(user)
  end

  def following?(user)
    followed_users.include?(user)
  end

  def sleep
    sleep_tracker.sleep
  end

  def wake_up
    sleep_tracker.wake_up
  end

  def follow(user)
    follows.create(followed_user: user)
  end

  def unfollow(user)
    follows.find_by(followed_user: user).destroy
  end

  def following?(user)
    followed_users.include?(user)
  end

  private

  def sleep_tracker
    sleep_tracker ||= SleepTracker.new(sleep_tracking_repository)
  end

  def sleep_tracking_repository
    @sleep_tracking_repository ||= SleepTrackingRepository.new(self)
  end
end
