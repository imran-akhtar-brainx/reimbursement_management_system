Rails.application.routes.draw do
  root to: "employees#index"
  devise_for :users
  resources :employees do
    collection do
      get 'submitted_forms'
    end
  end
  resources :managers do
    member do
      get 'show_request'
      post 'set_status'
    end
    collection do
      get 'submitted_forms'
      get 'my_submitted_forms'
    end
  end
  resources :accountants do
    collection do
      get 'submitted_forms'
      get 'my_submitted_forms'
      get 'applicants'
      get 'user_submissions'
      get 'excel_generator'
    end
  end
  resources :forms
  resources :submissions
end
