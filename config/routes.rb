Rails.application.routes.draw do
  get 'clock/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :v1 do
    resources :sleep_trackers, only: [:index] do
    end
  end
end
