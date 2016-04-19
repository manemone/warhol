Rails.application.routes.draw do
  root 'sessions#new'

  resources :images, only: [:new, :create, :show]
  resource :user, only: [:edit, :update]
  resources :sessions, only: [:new, :destroy]

  # user authentication
  get 'auth/:provider/callback', to: 'sessions#callback'
  get '/logout', to: 'sessions#destroy'

  # api
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :images, only: [:show, :create]
    end
  end
end
