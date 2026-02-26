Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :planner_items
  resources :medications do
    resources :medication_logs, shallow: true
  end
  resources :mental_health_entries
  resources :journal_entries
  resources :todo_items
  get "/calendar", to: "calendar#index"
end
