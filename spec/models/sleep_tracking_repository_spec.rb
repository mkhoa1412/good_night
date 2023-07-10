require 'rails_helper'

RSpec.describe SleepTrackingRepository do
  let(:user) { FactoryBot.create(:user) }
  let(:sleep_tracking) { FactoryBot.build(:sleep_tracking, sleep_time: DateTime.now - 8.hours, wake_up_time: DateTime.now) }

  let(:repository) { SleepTrackingRepository.new(user) }

  describe "#add_sleep_tracking" do
    it "adds the sleep tracking to the user's sleep trackings" do
      repository.add_sleep_tracking(sleep_tracking)
      expect(user.sleep_trackings).to include(sleep_tracking)
    end
  end
end