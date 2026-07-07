Rails.application.routes.draw do
  get "pages/terms"
  get "pages/privacy"
  get "contacts/new"
  get "families/index"
  get "accounts/show"
  get "accounts/edit_profile"
  get "accounts/edit_email"
  get "accounts/edit_password"
  get "my_pages/show"
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
  get "mypage", to: "my_pages#show"
  # アカウント
  get "account", to: "accounts#show"
  get "account/profile", to: "accounts#edit_profile"
  get "account/email", to: "accounts#edit_email"
  get "account/password", to: "accounts#edit_password"

# 家族管理
  resources :families, only: [:index]

# お問い合わせ
  resources :contacts, only: [:new]

# 利用規約・プライバシーポリシー
  get "terms", to: "pages#terms"
  get "privacy", to: "pages#privacy"
end
