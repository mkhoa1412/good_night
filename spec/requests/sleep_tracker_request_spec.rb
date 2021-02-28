require 'rails_helper'

RSpec.describe SleepTracker, type: :request do
  describe 'GET /index' do
    before do
      create_list(:sleep_tracker, 3, clocked_in: Time.current)
      get '/sleep_trackers'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'JSON body response contains expected recipe attributes' do
      data = JSON.parse(response.body)
      expect(data['data'].size).to eq(3)
    end
  end
end
