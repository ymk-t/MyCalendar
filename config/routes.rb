Rails.application.routes.draw do
  root to: 'home#index' 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: 'json' } do
    resources :events, only: [:index, :show, :create] 
  end
end
