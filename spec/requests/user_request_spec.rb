require 'rails_helper'

RSpec.describe User, type: :request do
  before do
    @user = create(:user)
  end
  describe 'GET /users/{id}/fetch_all_clocked_in' do
    before do
      @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-01 09:00 PM',
                                                        clocked_out: '2021-02-02 06:00 AM'))
      @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-02 09:00 PM',
                                                        clocked_out: '2021-02-03 06:00 AM'))
      @user.add_sleeping_tracked(create(:sleep_tracker, clocked_in: '2021-02-03 09:00 PM',
                                                        clocked_out: '2021-02-04 06:00 AM'))
      get "/users/#{@user.id}/fetch_all_clocked_in"
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'JSON body response contains expected recipe attributes' do
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data].size).to eq(3)
    end
  end

  describe 'PUT /users/{id}/follow' do
    context 'valid follower' do
      before do
        @follower = create(:user)

        put "/users/#{@user.id}/follow", params: {
          user: {
            follower_id: @follower.id
          }
        }
      end

      it 'returns http success' do
        expect(response.status).to eq(200)
      end
      it 'JSON body response contains expected recipe attributes' do
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:data][:relationships][:followees][:data].size).to eq(1)
        expect(json[:data][:relationships][:followees][:data][0][:id].to_i).to eq(@follower.id)
      end
      it 'the user followees updated ' do
        expect(@user.reload.followees).to eq([@follower])
      end
    end

    context 'invalid follower' do
      before do
        @follower = build_stubbed(:user)

        put "/users/#{@user.id}/follow", params: {
          user: {
            follower_id: @follower.id
          }
        }
      end
      it 'returns  HTTP Status 422 Unprocessable entity' do
        expect(response.status).to eq(422)
      end

      it 'response should contain error message' do
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:error]).to eq('follow failed')
      end

      it 'The user followees unchanged' do
        expect(@user.reload.followees).to eq([])
      end
    end
  end

  describe 'PUT /users/{id}/unfollow' do
    context 'valid follower' do
      before do
        @follower = create(:user)
        @user.followees << @follower

        put "/users/#{@user.id}/unfollow", params: {
          user: {
            follower_id: @follower.id
          }
        }
      end

      it 'returns http success' do
        expect(response.status).to eq(200)
      end
      it 'JSON body response contains expected recipe attributes' do
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:data][:relationships][:followees][:data].size).to eq(0)
      end
      it 'the user followees updated ' do
        expect(@user.reload.followees).to eq([])
      end
    end

    context 'invalid follower' do
      before do
        @follower = build_stubbed(:user)
        @user.followees << create(:user)
        put "/users/#{@user.id}/unfollow", params: {
          user: {
            follower_id: @follower.id
          }
        }
      end
      it 'returns  HTTP Status 422 Unprocessable entity' do
        expect(response.status).to eq(422)
      end

      it 'response should contain error message' do
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:error]).to eq('unfollow failed')
      end

      it 'The user followees unchanged' do
        expect(@user.reload.followees.size).to eq(1)
      end
    end
  end

  describe 'GET /users/{id}/sleep_records_last_week_of_followees' do
    before do
      @last_week = 7.days.ago
      @user2 = create(:user)
      @user2.add_sleeping_tracked(create(:sleep_tracker, clocked_in: @last_week, clocked_out: @last_week + 8.hour))
      @user.follow(@user2)
      get "/users/#{@user.id}/sleep_records_last_week_of_followees"
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'JSON body response contains expected recipe attributes' do
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data].size).to eq(1)
    end
  end
end
