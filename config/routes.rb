# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'posts#index'

  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do 
    get '/users/sign_up/avatar', to: 'users/registrations#avatar', as: 'signup_avatar'
    put '/users/sign_up/avatar', to: 'users/registrations#signup_set_avatar', as: 'signup_set_avatar'
  end

  resources :likes
  resources :posts

end
