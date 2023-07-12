require 'rails_helper'

RSpec.describe SleepTracking, type: :model do
  let(:user) { FactoryBot.create(:user) }
  
  describe 'validations' do
    it 'is valid with valid attributes' do
      sleep_tracking = FactoryBot.build(:sleep_tracking, user: user, sleep_time: DateTime.now - 8.hours, wake_up_time: DateTime.now)
      expect(sleep_tracking).to be_valid
    end
    
    it 'is not valid without sleep_time' do
      sleep_tracking = FactoryBot.build(:sleep_tracking, user: user, sleep_time: nil)
      expect(sleep_tracking).not_to be_valid
    end
    
    it 'is not valid without wake_up_time' do
      sleep_tracking = FactoryBot.build(:sleep_tracking, user: user, wake_up_time: nil)
      expect(sleep_tracking).not_to be_valid
    end
    
    it 'is not valid if sleep_time is after wake_up_time' do
      sleep_tracking = FactoryBot.build(:sleep_tracking, user: user, sleep_time: DateTime.now, wake_up_time: DateTime.now - 1.hour)
      expect(sleep_tracking).not_to be_valid
    end
  end
  
  describe 'calculates the sleep_duration' do
    it 'is correct value' do
      sleep_tracking = FactoryBot.build(:sleep_tracking, user: user, sleep_time: DateTime.now - 8.hours, wake_up_time: DateTime.now)
      sleep_tracking.save

      expect(sleep_tracking.sleep_duration).to eq(28800)
    end
  end
end