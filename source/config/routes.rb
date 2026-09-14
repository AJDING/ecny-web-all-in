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
    get :results, on: :member
  end
  get "my_plan", to: "assessments#plan"     # Personal Ministry Plan (all results)

  resource :appointment, only: [:show, :create]

  namespace :admin do
    root "dashboard#index"
    resources :users, only: [:index, :show]
    resources :lessons, only: [:index, :edit, :update]
    resources :appointments, only: [:index, :update]
  end
end
