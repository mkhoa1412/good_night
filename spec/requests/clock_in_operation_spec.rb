require 'rails_helper'

RSpec.describe 'Api::V1::SleepTrackingsController', type: :request do
  describe 'GET #clock_in_operation' do
    let!(:sleep_trackings) {create_list(:sleep_tracking, 20)}

    before do
      get '/api/v1/sleep_trackings/clock_in_operation'
    end

    it 'returns correct status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the expected JSON response' do
      expect(json).to have_key('pagy')
      expect(json).to have_key('clock_in_operation')
    end

    it 'return all clocked-in times' do
      expect(json.fetch('clock_in_operation', []).size).to eq(20)
    end
  end
end