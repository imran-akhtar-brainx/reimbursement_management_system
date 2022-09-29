Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  # resources :roles
  resources :employees
  resources :managers do
    member do
      get 'show_request'
    end
    member do
      post 'set_status'
    end
  end
  resources :accountants
  resources :forms
  resources :submissions
end
