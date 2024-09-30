Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
  get 'confirmation_notice', to: 'home#confirmation_notice', as: :confirmation_notice

  namespace :admin do
    resources :users do
      collection do
        get :unconfirmed
      end
      member do
        patch :give_direct_sale
        post :resend_email
      end
    end
    resources :membership_codes
    resources :low_income_codes
    resources :low_income_requests, only: %i[index] do
      member do
        post :approve
        post :reject
      end
    end
    resources :events, only: %i[index show new create update edit] do
      resources :volunteer_roles do
        resources :volunteers
      end
    end
  end
  resources :events, only: %i[patch] do
    patch :clear_discount_from_cache
    resources :volunteer_roles, only: [] do
      resources :volunteers, only: %i[index new create destroy update]
    end
    resources :volunteering, only: %i[index]
  end
  resources :low_income_requests
  root to: 'home#index'
end
