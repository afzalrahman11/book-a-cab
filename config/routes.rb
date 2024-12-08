Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # Root route
  root "dashboard#home"

  # Resources
  resources :users, only: [ :index, :show, :destroy ]
  resources :cabs, only: [ :index ]
  resources :rides, only: [ :create, :show ] do
    patch :update_status, on: :member
    get :daily_collection, on: :collection
  end

  # Custom Routes
  get "locations/search", to: "locations#search"
  post "rides/book", to: "rides#book", as: :book_ride
end
