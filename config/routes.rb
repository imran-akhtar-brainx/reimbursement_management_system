Rails.application.routes.draw do
  root to: "employees#index"
  devise_for :users
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
