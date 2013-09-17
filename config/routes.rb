EligibleRailsDemo::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resource :settings, only: [:edit, :update]

  resources :providers

  root 'home#index'
end
