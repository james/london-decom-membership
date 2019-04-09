Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
  get 'confirmation_notice', to: 'home#confirmation_notice', as: :confirmation_notice

  namespace :admin do
    resources :users
    resources :membership_codes
    resources :events, only: %i[index show] do
      resources :volunteer_roles do
        resources :volunteers
      end
    end
  end
  resources :events, only: %i[show] do
    resources :volunteer_roles, only: [] do
      resources :volunteers, only: %i[index new create destroy update]
    end
  end
  root to: 'home#index'
end
