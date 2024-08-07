Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index,:show] do 
    member do
      get "followers"
      get "followings"
    end
  end
  # Todo this has to be inside users resources, maybe we can use put method for pending request
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  post '/users/:id/accept', to: "users#accept_request", as: "accept_request"
  post '/users/:id/cancel', to: "users#cancel_request", as: "cancel_request"
  resources :posts do
    resources :comments , only: [:create,:destroy]
    member do
      post "like"
      delete "unlike"
      get "likes"
    end
  end
  resources :notifications, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "posts#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
