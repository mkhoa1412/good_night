require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'GET /users/{id}/fetch_all_clocked_in' do
    before do
      @user = create(:user)
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
      data = JSON.parse(response.body)
      expect(data['data'].size).to eq(3)
    end
  end
end
