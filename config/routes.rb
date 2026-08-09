Rails.application.routes.draw do
  # =========================
  # 認証
  # =========================
  devise_for :users

  # =========================
  # ホーム
  # =========================
  root "home#index"
  get "dashboard", to: "dashboard#index"

  # =========================
  # ご褒美・ガチャ
  # =========================
  get "gacha", to: "gacha#show"
  post "gacha/draw", to: "gacha#draw"

  get "reward_cards", to: "reward_cards#index"

  # ご褒美依頼
  post "reward_requests",
  to: "reward_requests#create",
  as: :reward_requests

  # 自分のカードを使う確認
  get "reward_cards/:id/use",
      to: "reward_cards#use_confirm",
      as: :use_reward_card

# =========================
# みんなOKになったカード
# =========================

get "reward_cards/:id/approved",
to: "reward_cards#approved",
as: :approved_reward_card

delete "reward_cards/:id/approved",
to: "reward_cards#destroy_approved",
as: :destroy_approved_reward_card


  # 家族からの依頼確認
  get "reward_cards/:id/confirm",
      to: "reward_cards#confirm",
      as: :confirm_reward_card

  # 家族からの依頼を完了
  patch "reward_cards/:id/complete",
        to: "reward_cards#complete",
        as: :complete_reward_card

  # =========================
  # 家事
  # =========================
  get "tasks", to: "tasks#index"

  resources :task_categories, only: [ :index ]

  resources :task_logs, only: [ :new, :create ] do
    get :complete, on: :collection
  end

  get "task_histories", to: "task_histories#index"

  # =========================
  # 家族
  # =========================
  resources :families, only: [ :index, :new, :create ]
  resources :family_joins, only: [ :new, :create ]
  resources :family_invites, only: [ :show ]

  # =========================
  # マイページ
  # =========================
  get "mypage", to: "my_pages#show"

  # =========================
  # アカウント設定
  # =========================
  get "account", to: "accounts#show"

  # プロフィール変更
  get "account/profile", to: "profiles#edit"
  patch "account/profile",
        to: "accounts#update_profile",
        as: :update_account_profile

  # キャラクター変更
  get "profile/select_character",
      to: "profiles#select_character"
  patch "profile/select_character",
        to: "profiles#select_character"

  # メールアドレス変更
  get "account/email", to: "accounts#edit_email"
  patch "account/email",
        to: "accounts#update_email",
        as: :update_account_email

  # パスワード変更
  get "account/password", to: "accounts#edit_password"
  patch "account/password",
        to: "accounts#update_password",
        as: :update_account_password

  # プロフィール
  resource :profile, only: [ :show, :edit, :update ]

  # 役割設定
  resource :role_setting, only: [ :edit, :update ]

  # =========================
  # キャラクター
  # =========================
  get "characters/select", to: "characters#select"
  get "characters/show", to: "characters#show"

  # =========================
  # お問い合わせ
  # =========================
  resources :contacts, only: [ :new ]

  # =========================
  # 法的ページ
  # =========================
  get "terms", to: "pages#terms"
  get "privacy", to: "pages#privacy"

  # =========================
  # PWA
  # =========================
  get "manifest",
      to: "rails/pwa#manifest",
      as: :pwa_manifest

  # =========================
  # ヘルスチェック
  # =========================
  get "up",
      to: "rails/health#show",
      as: :rails_health_check
end
