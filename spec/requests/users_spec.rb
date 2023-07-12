require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe "POST /api/v1/users/:id/follow" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:headers) { { "Authorization" => "Token #{user.auth_token}" } }
    before do
      post "/api/v1/users/#{other_user.id}/follow", headers: headers 
    end 

    it "returns a success status" do
      expect(response).to have_http_status(:created)
    end

    it "returns a success message" do
      expect(json["message"]).to eq("You are now following #{other_user.name}")
    end
  end

  describe "DELETE /api/v1/users/:id/unfollow" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:headers) { { "Authorization" => "Token #{user.auth_token}" } }

    before do
      user.follow(other_user)
      delete "/api/v1/users/#{other_user.id}/unfollow", headers: headers
    end

    it "returns a success status" do
      expect(response).to have_http_status(:ok)
    end

    it "returns a success message" do
      expect(json["message"]).to eq("You have unfollowed #{other_user.name}")
    end
  end

  describe 'GET friend_sleep_records' do
    let(:user) { create(:user) }
    let(:friend1) { create(:user) }
    let(:friend2) { create(:user) }
    let(:friend3) { create(:user) }
    let!(:sleep_record1) { create(:sleep_tracking, user: friend1, created_at: 2.days.ago) }
    let!(:sleep_record2) { create(:sleep_tracking, user: friend2, created_at: 1.day.ago) }
    let!(:sleep_record3) { create(:sleep_tracking, user: friend3, created_at: 3.days.ago) }
    let!(:sleep_record4) { create(:sleep_tracking, user: friend1, created_at: 8.days.ago) }
    let(:headers) { { "Authorization" => "Token #{user.auth_token}" } }

    before do
      user.follow(friend1)
      user.follow(friend2)
      get '/api/v1/users/friend_sleep_records', headers: headers
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the sleep records of friends within the past week' do
      expect(json.size).to eq(2)
      expect(json[0]['id']).to eq(sleep_record2.id)      # expect(json).not_to include(sleep_record3.to_json)
      expect(json[1]['id']).to eq(sleep_record1.id)      # expect(json).not_to include(sleep_record3.to_json)
    end
  end
end