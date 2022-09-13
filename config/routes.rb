Rails.application.routes.draw do
  # root to: "employees#index"
  devise_for :users
  # resources :roles
  resources :employees
  resources :managers
  resources :accountants
end
