Rails.application.routes.draw do
  root 'sessions#new'

  resources :images, only: [:index, :create, :show, :destroy] do
    member do
      get ':geometry', constraints: { geometry: /(\A\d+x\d+\Z)|(\Ax\d+\Z)|(\A\d+x\Z)/ }, to: "images#resize"
    end
  end
  resource :user, only: [:show] do
    resource :api_key, only: [:update]
  end
  resources :sessions, only: [:new, :destroy]

  # user authentication
  get 'auth/:provider/callback', to: 'sessions#callback'
  get '/logout', to: 'sessions#destroy'

  # api
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :images, only: [:show, :create, :destroy]
    end
  end
end
