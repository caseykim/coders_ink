Rails.application.routes.draw do
  root 'tattoos#index'
  devise_for :users, controllers: { registrations: :registrations }

  resources :users, only: [:index, :show, :destroy] do
    resources :admin, only: :create
  end

  resources :admin, only: :destroy

  resources :tattoos do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:show] do
    post 'upvote'
    post 'downvote'
  end

  resources :reviews, only: [:edit, :update, :destroy]
end
