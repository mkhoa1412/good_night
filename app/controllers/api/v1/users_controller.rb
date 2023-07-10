module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user

      def index
        render json: {}, status: :ok
      end
  
    end
  end
end