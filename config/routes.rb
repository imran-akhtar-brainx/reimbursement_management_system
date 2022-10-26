Rails.application.routes.draw do
  namespace :supervisor do
      resources :users
      root to: "users#index"
    end
  namespace :admin do
      resources :submissions
      resources :roles
      resources :forms
      resources :users

      root to: "submissions#index"
    end
  root to: "employees#index"
  devise_for :users
  resources :employees do
    collection do
      get 'submitted_forms'
      get 'form_submissions'
    end
  end
  resources :managers do
    member do
      get 'show_request'
      post 'set_status'
    end
    collection do
      get 'submitted_forms'
      get 'form_submissions'
      get 'requested_employees'
    end
  end
  resources :accountants do
    collection do
      get 'applicants'
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
      get 'employee_submissions'
      get 'filtered'
    end
  end
end
