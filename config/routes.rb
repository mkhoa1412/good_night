Rails.application.routes.draw do
  get 'clock/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :v1 do
    resources :sleep_trackers, only: [:index] do
    end

    resources :users, only: [] do
      get :fetch_all_clocked_in
      put :follow
      put :unfollow
      get :sleep_records_last_week_of_followees
    end
  end
end
