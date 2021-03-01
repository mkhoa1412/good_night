class AddSleepingTimeToSleepTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :sleep_trackers, :sleeping_time, :integer, default: 0
  end
end
