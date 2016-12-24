Rails.application.routes.draw do
  resources :projects
  resources :organizations
  devise_for :users
  resources :users, :only => [:show, :index]
  root 'home#index'
end
