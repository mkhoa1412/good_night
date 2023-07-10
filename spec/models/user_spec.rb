require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

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

  describe '#follow' do
    let(:followed_user) { create(:user) }

    it 'adds the user to the followed_users association' do
      user.follow(followed_user)
      expect(user.followed_users).to include(followed_user)
    end
  end

  describe '#unfollow' do
    let(:followed_user) { create(:user) }

    it 'removes the user from the followed_users association' do
      user.follow(followed_user)
      user.unfollow(followed_user)
      expect(user.followed_users).not_to include(followed_user)
    end
  end

  describe '#following?' do
    let(:followed_user) { create(:user) }

    it 'returns true if the user is being followed' do
      user.follow(followed_user)
      expect(user.following?(followed_user)).to be true
    end

    it 'returns false if the user is not being followed' do
      expect(user.following?(followed_user)).to be false
    end
  end
end