Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: "users/sessions",
        registrations: "users/registrations"
      }

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "home#index"
  resources :users, only: [ :index, :show ]
end
