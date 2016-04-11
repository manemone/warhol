Rails.application.routes.draw do
  root 'images#new'

  resources :images, only: [:new, :create, :show]

  # user authentication
  get 'auth/:provider/callback', to: 'sessions#callback'
  get '/logout', to: 'sessions#destroy'
end
