Rails.application.routes.draw do
  resources :projects do
    member do
      get "apply", to: "projects#submit_application"
    end
  end
  resources :organizations
  devise_for :users, :controllers => { :registrations => :registrations }
  resources :users, :only => [:show, :index]
  root 'home#index'
  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end
end
