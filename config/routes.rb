Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }

  get 'confirmation_notice', to: 'home#confirmation_notice', as: :confirmation_notice
  root to: 'home#index'
end
