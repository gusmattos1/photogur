Rails.application.routes.draw do

  resource :sessions, only: [:new, :create, :destroy]
  resource :users, only: [:new, :create]
  resources :pictures
    root 'pictures#index'
end
