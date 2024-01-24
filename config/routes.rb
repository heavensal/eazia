Rails.application.routes.draw do

  root 'posts#new'

  devise_for :users

  resources :posts do
    resource :gpt_creation, only: [], controller: 'gpt_creations' do
      patch :rewrite, on: :member
      patch :recreate, on: :member
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
  get 'pages/account'
  get 'pages/quartz_agency'
  get 'pages/contact'
  get 'pages/cgu'
  get 'pages/confidentialite'




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
