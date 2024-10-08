Rails.application.routes.draw do
  resources :competitions
  resources :sparrings
  root "statics#index"
  
  resources :payments
  resources :sparrings
  resources :competitions
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
}

devise_scope :user do
     get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  #Client namespace
  namespace :client do
    resources :fields, only: [:new, :create, :index, :show, :edit]
    resources :client_fields, only: [:new, :create, :index, :show]
    resources :dashboards, only: [:show, :index]
    resources :management_fields, only: [:index, :new, :create, :edit, :update, :destroy]
      # resources :sparrings, only: [:new, :create, :index, :show]
    # resources :client_sparrings, only: [:new, :create, :index, :show]
    # resources :competitions, only: [:new, :create, :index, :show]
    # resources :client_competitions, only: [:new, :create, :index, :show]
    resources :client_bookings, only: [:new, :create, :index, :show]
    resources :payments, only: [:new, :create]
    resources :management_fields
    resources :fields do
      resources :bookings, only: [:new, :create, :edit, :update, :show]
      resources :payments, only: [:new, :create]
    end
  end
  
  resources :fields, only: [:show, :index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  

  # Defines the root path route ("/")
  # root "posts#index"
end
