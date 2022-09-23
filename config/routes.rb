Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  # resources :roles
  resources :employees
  resources :managers
  resources :accountants
  resources :forms
end
