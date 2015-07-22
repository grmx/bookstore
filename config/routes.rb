Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'books#index'
  resources :books
  resources :categories, only: :show
  get 'about', to: 'pages#about'
  get 'help',  to: 'pages#help'
end
