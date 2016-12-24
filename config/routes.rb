Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:show, :index]
  root 'home#index'
end
