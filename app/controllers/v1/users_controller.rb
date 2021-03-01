module V1
  class UsersController < ApplicationController
    def fetch_all_clocked_in
      @user = find_user
      @pagy, @data = pagy_array(@user.fetch_all_clocked_in)
      success_response({ data: @data, meta: { pagy: pagy_metadata(@pagy) } }, :ok)
    end

    def follow
      @user = find_user
      follower = User.find_by(id: user_params[:follower_id])
      if follower && @user.follow(follower)
        options = { include: %i[followees followers] }
        success_response(UserSerializer.new(@user, options).serializable_hash, :ok)
      else
        error_response({ error: 'follow failed' }, :unprocessable_entity)
      end
    end

    def unfollow
      @user = find_user
      follower = User.find_by(id: user_params[:follower_id])
      if follower && @user.unfollow(follower)
        options = { include: %i[followees followers] }
        success_response(UserSerializer.new(@user, options).serializable_hash, :ok)
      else
        error_response({ error: 'unfollow failed' }, :unprocessable_entity)
      end
    end

    def sleep_records_last_week_of_followees
      @user = find_user
      @pagy, @data = pagy_array(@user.sleep_records_last_week_of_followees)
      success_response({ data: @data, meta: { pagy: pagy_metadata(@pagy) } }, :ok)
    end

    private

    def find_user
      User.find(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:follower_id)
    end
  end
end
