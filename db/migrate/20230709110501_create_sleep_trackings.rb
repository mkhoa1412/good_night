class CreateSleepTrackings < ActiveRecord::Migration[6.1]
  def change
    create_table :sleep_trackings do |t|
      t.datetime :sleep_time, null: false
      t.datetime :wake_up_time, null: false
      t.integer :sleep_duration, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
