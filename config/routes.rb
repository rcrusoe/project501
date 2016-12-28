Rails.application.routes.draw do
  root 'home#index'
  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end

  devise_for :users, :controllers => { :registrations => :registrations }
  resources :users, :only => [:show, :index]

  resources :projects do
    member do
      get "apply", to: "projects#submit_application"
    end
  end

  resources :organizations
end
