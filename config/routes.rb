Rails.application.routes.draw do

  root 'pages#landing'

  resources :products, only: [:index] do
    get 'payments/checkout'
    get 'payments/success'
    get 'payments/cancel'
  end

  get 'cart', to: 'payments#index', as: 'cart'

  resources :subscriptions, only: [:index] do
    get 'payments/checkout'
    get 'payments/success'
    get 'payments/cancel'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }


  put 'users/update_token', to: 'users#update_token', as: 'update_user_token'
  resources :posts do
    member do
      patch :publish
    end
    resource :gpt_creation, only: [], controller: 'gpt_creations' do
      get :edit, on: :member
      patch :update, on: :member
      patch :recreate, on: :member
    end
    resources :photos, only: [:create, :destroy] do
      post :load_my_photo, on: :collection
      patch :select, on: :member
    end
  end
  get '/drafts', to: 'posts#drafts', as: "drafts"

  require "sidekiq/web"
  authenticate :user, ->(user) { user.status == "admin" } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Pages Controller
  get 'pages/cgv'
  get 'pages/legal'
  get 'pages/account', to: 'pages#account', as: 'account'
  get 'pages/quartz_agency'
  get 'pages/contact'
  get 'pages/cgu'
  get 'pages/confidentialite'
  get 'pages/inscription'

  patch 'pages/update_account', to: 'pages#update_account', as: 'pages_update_account'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"

  ##############################
  # ADMIN
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :gpt_creations, only: [:index, :show]
    resources :instagram_accounts, only: [:index, :show]
  end
end
