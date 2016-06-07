Rails.application.routes.draw do
  root 'root#index'

  resources :users, only: [:new, :create, :destroy]
  resources :links, only: [:index, :create, :edit, :update]
  resources :sessions, only: [:new, :create]

  namespace :api, :defaults => {format: :json }do
    namespace :v1 do
      resources :links, only: [:update, :index]
    end
  end
end
