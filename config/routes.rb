Rails.application.routes.draw do
  resources :projects do
    member do
      get "apply", to: "projects#submit_application"
    end
  end
  resources :organizations
  devise_for :users
  resources :users, :only => [:show, :index]
  root 'home#index'
end
