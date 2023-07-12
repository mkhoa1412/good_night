require 'rails_helper'

RSpec.describe SleepTracker do
  let(:user) { FactoryBot.create(:user)}
  let(:sleep_tracking_repository) { SleepTrackingRepository.new(user) }
  
  describe "#sleep" do
    let(:sleep_tracker) { SleepTracker.new(sleep_tracking_repository) }

    it "sets the sleep time of the current sleep" do
      sleep_time = DateTime.now
      sleep_tracker.sleep(sleep_time)
      expect(sleep_tracker.current_sleep.sleep_time).to eq(sleep_time)
    end
  end

  describe "#wake_up" do
    let(:sleep_tracker) { SleepTracker.new(sleep_tracking_repository) }
    context 'when not sleeping' do
      it "raises a StandardError with 'You are not sleeping'" do
        expect { sleep_tracker.wake_up }.to raise_error(StandardError, "You are not sleeping")
      end
    end

    context 'when sleeping' do
      before do
        sleep_tracker.sleep
      end

      it 'should set the wake up time to the current time' do
        wake_up_time = DateTime.now
        sleep_tracker.wake_up(wake_up_time)
        expect(sleep_tracker.current_sleep.wake_up_time).to eq(wake_up_time)
      end

      it 'should add the sleep tracking to the repository' do
        expect(sleep_tracking_repository).to receive(:add_sleep_tracking).with(sleep_tracker.current_sleep)
        sleep_tracker.wake_up
      end
    end
  end
end