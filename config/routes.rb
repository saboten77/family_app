Rails.application.routes.draw do
  get "family_invites/show"

  resource :profile, only: [ :edit, :update ]
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
end
