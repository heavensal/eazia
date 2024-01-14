Rails.application.routes.draw do
  get 'pages/cgv'
  get 'pages/legal'
  get 'pages/account'
  get 'pages/quartz_agency'
  get 'pages/contact'
  root 'posts#new'
  devise_for :users
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
