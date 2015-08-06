Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'books#index'
  resources :books do
    resources :ratings,   only: :create
  end
  resources :categories,  only: :show
  resources :order_items, only: [:create, :update, :destroy]
  resources :order_steps, only: [:index, :show, :update]
  resources :orders,      only: [:index, :show]
  resource  :cart, only: :show
  get 'about', to: 'pages#about'
  get 'help',  to: 'pages#help'
end
