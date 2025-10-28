Rails.application.routes.draw do
  root "home#index"
  
  # Locale switching
  post "switch_locale", to: "application#switch_locale"
  
  # Settings
  get "settings", to: "settings#index", as: :settings
  post "settings/toggle_dark_mode", to: "settings#toggle_dark_mode", as: :toggle_dark_mode
  
  # Devise routes with custom paths and controllers
  devise_for :users, path: '', path_names: {
    sign_in: 'sign-in',
    sign_up: 'sign-up',
    sign_out: 'sign-out',
    edit: 'edit/profile'
  }, controllers: {
    registrations: 'users/registrations'
  }
  
  # Custom profile routes (must be after other routes to avoid conflicts)
  get ':username', to: 'users#profile', as: :user_profile, constraints: { username: /[a-z0-9._]+/ }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

end
