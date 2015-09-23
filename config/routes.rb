Rails.application.routes.draw do
  root 'tattoos#index'
  devise_for :users, controllers: { registrations: :registrations }

  resources :users, only: [:index, :show]

  resources :tattoos do
    resources :reviews, only: [:new, :create]
  end
end
