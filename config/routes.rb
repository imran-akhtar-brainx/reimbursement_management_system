Rails.application.routes.draw do
  namespace :admin do
    resources :roles
    resources :forms
    resources :users
    devise_for :users
    root to: "users#index"
  end
  root to: "submissions#index"
  devise_for :users
  resources :employees do
    collection do
      get 'submitted_forms'
      get 'form_submissions'
    end
    root to: "employees#index"
  end
  resources :managers do
    member do
      get 'show_request'
      post 'set_status'
    end
    collection do
      get 'submitted_forms'
      get 'form_submissions'
      get 'applicants'
    end
  end
  resources :accountants do
    collection do
      get 'employees'
      get 'user_submissions'
      get 'excel_generator'
    end
  end
  resources :forms do
    collection do
      get 'submitted_forms'
    end
  end
  resources :submissions do
    collection do
      get 'filtered'
    end
    get 'user_submissions', on: :member
  end
end
