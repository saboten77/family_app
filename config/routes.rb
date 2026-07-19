Rails.application.routes.draw do
  get "characters/select"
  get "characters/show"
  get "role_settings/edit"
  get "task_logs/new"
  get "task_logs/create"
  get "task_categories/index"
  get "family_invites/show"
  get "profile/change_character", to: "profiles#change_character"
  patch "profile/change_character", to: "profiles#change_character"

  # ユーザー認証（Devise）
  devise_for :users

  # ホーム画面
  root "home#index"

  # ダッシュボード
  get "dashboard", to: "dashboard#index"

  # 家事一覧
  get "tasks", to: "tasks#index"

  # 家事履歴
  get "task_histories", to: "task_histories#index"

  # マイページ
  get "mypage", to: "my_pages#show"

  # アカウント設定
  get "account", to: "accounts#show"

  # プロフィール変更
  get "account/profile", to: "accounts#edit_profile"
  patch "/account/profile", to: "accounts#update_profile", as: :update_account_profile
  
  get "profile/select_character", to: "profiles#select_character"
  patch "profile/select_character", to: "profiles#select_character"

  # メールアドレス変更
  get "account/email", to: "accounts#edit_email"

  # パスワード変更
  get "account/password", to: "accounts#edit_password"

  # 家族管理
  resources :families, only: [ :index, :new, :create ]
  resources :family_joins, only: [ :new, :create ]
  resources :family_invites, only: [ :show ]

  # お問い合わせ
  resources :contacts, only: [ :new ]

  # 利用規約
  get "terms", to: "pages#terms"

  # プライバシーポリシー
  get "privacy", to: "pages#privacy"

  # ヘルスチェック（Render確認用）
  get "up" => "rails/health#show", as: :rails_health_check

  resources :family_invites, only: [ :show ]
  resources :task_categories, only: [ :index ]
  resources :task_logs, only: [ :new, :create ]
  resource :profile, only: [ :show, :edit, :update ]
  resource :role_setting, only: [ :edit, :update ]
  resources :task_logs do
  get :complete, on: :collection
end
end
