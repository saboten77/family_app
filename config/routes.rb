Rails.application.routes.draw do
  get "task_histories/index"
  get "tasks/index"
  get "dashboard/index"
  devise_for :users
  root "home#index"
  get "dashboard", to: "dashboard#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
  get "tasks", to: "tasks#index"
  get "task_histories", to: "task_histories#index"
end
