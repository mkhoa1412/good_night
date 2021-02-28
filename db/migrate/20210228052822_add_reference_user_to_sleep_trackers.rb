class AddReferenceUserToSleepTrackers < ActiveRecord::Migration[6.1]
  def change
    add_reference :sleep_trackers, :user, foreign_key: true, index: true
  end
end
