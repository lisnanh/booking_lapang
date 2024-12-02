Rails.application.routes.draw do
  resources :schedules
  resources :venues
  resources :competitions
  resources :sparrings
  root "statics#index"

  resources :payments
  resources :sparrings
  resources :competitions
  resources :fields

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  # Client namespace
  namespace :client do
    resources :venues, only: [:index, :show, :new, :edit, :update, :create, :destroy] do
      resources :fields, only: [:index, :show, :new, :edit, :update, :create, :destroy] do
        resources :bookings, only: [:index, :show, :new, :edit, :update, :create, :destroy]  # Booking di dalam fields
        resources :payments, only: [:new, :create]
      end
      resources :management_fields, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end
    resources :client_fields, only: [:new, :create, :index, :show]
    resources :schedules, only: [:index, :update]
    resources :dashboards, only: [:show, :index]
    resources :client_bookings, only: [:new, :create, :index, :show]  # Jika diperlukan, bisa ditambahkan resources ini
    resources :payments, only: [:new, :create]
  end
end
