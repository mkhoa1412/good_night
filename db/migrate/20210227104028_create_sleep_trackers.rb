class CreateSleepTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :sleep_trackers do |t|
      t.text :clocked_in, null: false
      t.text :clocked_out

      t.timestamps
    end
  end
end
