class User < ApplicationRecord
  has_many :sleep_trackers

  has_many :follower_followships,
           class_name: Followship.name,
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :followees, through: :follower_followships # is a user that follows another user.

  has_many :followee_followships,
           class_name: Followship.name,
           foreign_key: 'followee_id',
           dependent: :destroy
  has_many :followers, through: :followee_followships # is a user that is followed by another user.

  def add_sleeping_tracked(tracker)
    sleep_trackers << tracker
  end

  def fetch_all_clocked_in
    sleep_trackers.all.order(created_at: :desc).pluck(:clocked_in).map(&:to_s)
  end

  def follow(user)
    followees << user
  end

  def unfollow(followed_user)
    followees.delete followed_user
  end
end
