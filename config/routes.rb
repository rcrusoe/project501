Rails.application.routes.draw do
  
  root 'home#index'
  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end

  devise_for :users, controllers: { registrations: :registrations }
  resources :users do
    member do
      get "approve", to: "users#approve_user"
    end
  end

  resources :projects do
    member do
      get "apply", to: "projects#submit_application"
      get "close", to: "projects#close_project"
      get "open", to: "projects#open_project"
    end
  end

  resources :organizations
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]

  # static pages
  get '/about', to: 'home#about'
  get '/for-organizations', to: 'home#for_organizations'
  get '/admin/unapproved_users'
  get '/admin/projects'
end
