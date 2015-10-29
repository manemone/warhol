Rails.application.routes.draw do
  root 'images#new'

  resources :images, only: [:new, :create, :show]
end
