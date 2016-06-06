Rails.application.routes.draw do
  root 'root#index'

  resources :users, only: [:index, :new, :create, :show, :destroy]
end
