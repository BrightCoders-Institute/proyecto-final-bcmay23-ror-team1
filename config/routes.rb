# frozen_string_literal: true

Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: "users/registrations" }

  authenticated :user do
    root 'posts#index', as: :authenticated_root
  end  

  root 'welcome#index'

  get 'welcome', to: 'welcome#index', as: :welcome_index



  devise_scope :user do 
    get '/users/sign_up/avatar', to: 'users/registrations#avatar', as: 'signup_avatar'
    put '/users/sign_up/avatar', to: 'users/registrations#signup_set_avatar', as: 'signup_set_avatar'
    get '/users/:user_id(/:tab)', to: 'users/registrations#show',  constraints: { tab: /posts|likes|comments/ }, as: 'user'
  end

  resources :likes, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy]
  resources :shared_post, only: [:create, :destroy]
  resources :posts

  resources :search, only: [:index]

  resources :notifications, only: [:index, :create, :destroy, :put]

  get '/settings', to: 'users/settings#index', as: 'settings'

  # Uncomment the condition in development to see normal errors
  # if !Rails.env.development?
    get '*unmatched', to: 'application#route_not_found', constraints: lambda { |req|
      req.path.exclude? 'rails/active_storage'
    }
  # end

end
