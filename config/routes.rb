Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  root 'home#index'

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :likes

end
