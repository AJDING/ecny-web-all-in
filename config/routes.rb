Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  root "dashboard#show"                      # "My Next Step"
  get  "my_progress", to: "progress#show"    # full pathway view
  get  "faq",         to: "pages#faq"
  get  "terms",       to: "pages#terms"
  get  "privacy",     to: "pages#privacy"
  get  "up",          to: "rails/health#show" # uptime probe (Cloudflare / Render)

  resources :lessons, only: :show do
    post :complete, on: :member
  end

  resources :assessments, only: [:index, :show, :create] do
    get  :results,   on: :member
    post :interests, on: :member, to: "growth_interests#update"  # "I'd like to learn more about…"
  end
  get "my_plan",    to: "assessments#plan"   # My Profile: strengths + growth areas (Personal Ministry Plan)
  get "my_profile", to: redirect("/my_plan")

  resource :appointment, only: [:show, :create]  # Step Three: RSVP for the All In Sunday Gathering
  get "gathering", to: redirect("/appointment")

  namespace :admin do
    root "dashboard#index"
    resources :users, only: [:index, :show]
    resources :lessons, only: [:index, :edit, :update]
    resources :assessments, only: [:index, :show]
    resources :appointments, only: [:index, :update]
  end
end
