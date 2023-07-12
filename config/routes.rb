require "sidekiq/web"

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  if !Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV.fetch("SIDEKIQ_WEB_USER") &&
        password == ENV.fetch("SIDEKIQ_WEB_PASSWORD")
    end
  end
  mount Sidekiq::Web => "/sidekiq"
  mount PgHero::Engine, at: "pghero"

  namespace :api do
    namespace :v1 do
      resources :sleep_trackings, only: [] do
        collection do
          get :clock_in_operation
        end
      end

      resources :users, only: [] do
        collection do
          get :friend_sleep_records
        end
        member do
          post :follow
          delete :unfollow
        end
      end
    end
  end
end