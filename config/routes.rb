Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'books#index'
  resources :books do
    resources :ratings, only: :create
    get    'wishlist',  to: 'books#wishlist',             on: :collection
    post   'wishlist',  to: 'books#add_to_wishlist',      on: :member
    delete 'wishlist',  to: 'books#remove_from_wishlist', on: :member
  end
  resources :categories,  only: :show
  resources :order_items, only: [:create, :update, :destroy]
  resources :order_steps, only: [:index, :show, :update]
  resources :orders,      only: [:index, :show]
  resource  :cart,        only: :show
  get 'about', to: 'pages#about'
  get 'help',  to: 'pages#help'
end
