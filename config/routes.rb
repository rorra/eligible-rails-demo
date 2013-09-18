EligibleRailsDemo::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resource :settings, only: [:edit, :update]

  resources :providers
  resources :enrollments
  resource :demographics, only: [:new, :create]
  resource :coverage, only: [:new, :create], controller: :coverage
  resources :claims, only: [:index]
  resources :tickets
  resource :x12, only: [:new, :create], controller: :x12

  resources :payers, only: [:index]
  resources :service_types, only: [:index]

  root 'home#index'
end
