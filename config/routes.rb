EligibleRailsDemo::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resource :settings, only: [:edit, :update]

  resources :providers

  get '/about', to: 'home#about', as: :about

  root 'home#index'
end
