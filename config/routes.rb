Rails.application.routes.draw do
  root 'root#index'

  resources :users, only: [:new, :create, :destroy]
  resources :links, only: [:index, :create]
  resources :sessions, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
