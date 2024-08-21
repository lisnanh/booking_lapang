Rails.application.routes.draw do
  root "statics#index"
  resources :dashboards
  resources :payments
  resources :bookings
  resources :fields

  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  #Client namespace
  namespace :client do
    resources :fields, only: [:index, :show] # Adjust actions as needed
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  

  # Defines the root path route ("/")
  # root "posts#index"
end
