module V1
  class UsersController < ApplicationController
    def fetch_all_clocked_in
      @user = find_user
      @pagy, @data = pagy_array(@user.fetch_all_clocked_in)
      success_response({ data: @data, meta: { pagy: pagy_metadata(@pagy) } }, :ok)
    end

    private

    def find_user
      User.find(params[:user_id])
    end
  end
end
