Rails.application.routes.draw do

  resource :sessions, only: [:new, :create, :destroy]
  resource :users, only: [:new, :create]
  root 'pictures#index'
  resources :pictures
end
