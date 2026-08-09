class RewardCard < ApplicationRecord
  has_many :user_reward_cards, dependent: :destroy
  has_many :users, through: :user_reward_cards

  validates :name, presence: true
  validates :rarity, presence: true
  validates :image, presence: true
end
