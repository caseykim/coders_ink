Rails.application.routes.draw do
  root 'tattoos#index'
  devise_for :users
  resources :tattoos, only: [:index]
end
