require 'rails_helper'

RSpec.describe 'ApplicationController', type: :request do
  describe '#authenticate_user' do
    context 'when token is valid' do
      let(:user) { create(:user) }
      let(:token) { user.auth_token }

      it 'does not render unauthorized' do
        get '/api/v1/users', headers: { 'Authorization': "Token #{token}" }
        expect(response).not_to have_http_status(:unauthorized)
      end
    end

    context 'when token is invalid' do

      it 'renders unauthorized' do
        get '/api/v1/users', headers: { 'Authorization': 'Token invalid_token' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end