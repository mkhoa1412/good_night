require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe '#sleep' do
    let(:sleep_tracker) { instance_double('SleepTracker') }

    it 'calls the sleep method on the sleep tracker' do
      expect(sleep_tracker).to receive(:sleep)
      allow(user).to receive(:sleep_tracker).and_return(sleep_tracker)
      user.sleep
    end
  end

  describe '#wake_up' do
    let(:sleep_tracker) { instance_double('SleepTracker') }

    it 'calls the wake_up method on the sleep tracker' do
      expect(sleep_tracker).to receive(:wake_up)
      allow(user).to receive(:sleep_tracker).and_return(sleep_tracker)
      user.wake_up
    end
  end
end