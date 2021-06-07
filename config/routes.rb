Rails.application.routes.draw do
  get 'keijiban', to: 'keijiban#index'
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :communities do
    resources :posts
  end
  resources :subscriptions
  resources :comments, only: [:create, :destroy]
  post "post/vote" => "votes#create"
  post '/login/guest_sign_in', to: 'sessions#new_guest'
end
