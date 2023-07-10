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
end