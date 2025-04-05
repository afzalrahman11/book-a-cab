Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root route
  root "dashboard#home"

  # Resources
  resources :users, only: [ :index, :show, :destroy ]
  resources :cabs, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :rides, only: [ :create, :show, :index ] do
    patch :update_status, on: :member
    get :daily_collection, on: :collection
  end

  # Custom Routes
  get "locations/search", to: "locations#search"
  post "rides/book", to: "rides#book", as: :book_ride
end
