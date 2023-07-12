class ApplicationController < ActionController::API
  include Pagy::Backend
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user

  private

  def authenticate_user
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      user = User.find_by(auth_token: token)
      if user
        @current_user = user
      else
        false
      end
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
