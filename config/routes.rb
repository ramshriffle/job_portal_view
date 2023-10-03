Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  
  resources :users do
    resources :jobs
  end
  resources :jobs

  resources :users do
    resource :user_profiles
  end
  resource :user_profiles
  
  resources :users do
    resource :users_application
  end
  resources :users_application

  resources :job_seekers, only: [:index] do
    get 'view_all_jobs', on: :collection
  end
    
  resources :job_recruiters do
    member do
      get 'view_list_of_job_application'
      put 'accept_or_reject_job_application'
      get 'view_accepted_job_application'
      get 'view_rejected_job_application'
    end
  end
  post 'password/forgot', to: 'passwords#forgot_password'
  post 'password/reset', to: 'passwords#reset_password'

  root "jobs#index"
end
