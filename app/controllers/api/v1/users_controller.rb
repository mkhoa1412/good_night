module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user

      def follow
        user = User.find(params[:id])
        @current_user.follow(user)
        render json: { 
          message: "You are now following #{user.name}"
        }, status: :created
      end

      def unfollow
        user = User.find(params[:id])
        @current_user.unfollow(user)
        render json: { 
          message: "You have unfollowed #{user.name}" 
        }, status: :ok
      end
    end
  end
end