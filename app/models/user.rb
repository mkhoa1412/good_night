class User < ApplicationRecord
  has_many :sleep_trackers

  def add_sleeping_tracked(tracker)
    sleep_trackers << tracker
  end

  def fetch_all_clocked_in
    sleep_trackers.all.order(created_at: :desc).pluck(:clocked_in).map(&:to_s)
  end
end
