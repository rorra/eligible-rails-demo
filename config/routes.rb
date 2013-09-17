EligibleRailsDemo::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resource :settings, only: [:edit, :update]

  resources :providers
  resources :enrollments
  resource :demographics, only: [:new, :create]
  resource :coverage, only: [:show], controller: :coverage
  resources :claims, only: [:index]
  resources :tickets
  resource :x12, only: [:show], controller: :x12

  root 'home#index'
end
