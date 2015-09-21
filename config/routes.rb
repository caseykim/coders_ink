Rails.application.routes.draw do
  root 'tattoos#index'
  devise_for :users

  resources :users, only: [:index, :show]
  resources :tattoos, only: [:index, :show]
end
