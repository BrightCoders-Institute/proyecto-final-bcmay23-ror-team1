# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'posts#index'

  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do 
    get '/users/sign_up/avatar', to: 'users/registrations#avatar', as: 'signup_avatar'
    put '/users/sign_up/avatar', to: 'users/registrations#signup_set_avatar', as: 'signup_set_avatar'
    get '/users/:id(/:tab)', to: 'users/registrations#show',  constraints: { tab: /posts|likes/ }, as: 'user'
  end

  resources :likes, only: [:create, :destroy]
  resources :follows

  resources :search, only: [:index]

  resources :posts
  resources :notifications

  get '/settings', to: 'users/settings#index', as: 'settings'
  
end
