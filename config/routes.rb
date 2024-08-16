Rails.application.routes.draw do
  root "statics#index"
  resources :dashboards
  resources :payments
  resources :bookings
  resources :fields
  devise_for :users

  namespace :client do
    resources :fields, only: [:index, :show] # Adjust actions as needed
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  

  # Defines the root path route ("/")
  # root "posts#index"
end
