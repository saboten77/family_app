class User < ApplicationRecord
  belongs_to :family, optional: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :family_members
  has_many :families, through: :family_members

  has_many :user_reward_cards, dependent: :destroy
  has_many :reward_cards, through: :user_reward_cards

  has_many :reward_requests, dependent: :destroy
  has_many :completed_reward_requests,
         class_name: "RewardRequest",
         foreign_key: :completed_by_user_id,
         dependent: :nullify

end
