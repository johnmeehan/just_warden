# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login' => 'authentication#login'
      resources :stuffs, only: %i[index create]
    end
  end
  # resources :stuffs
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
