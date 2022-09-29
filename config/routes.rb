Rails.application.routes.draw do
  root to: "employees#index"
  devise_for :users
  resources :employees
  resources :managers
  resources :accountants
  resources :forms
  resources :submissions
end
