class UserRewardCard < ApplicationRecord
  belongs_to :user
  belongs_to :reward_card

  has_many :reward_requests,
           dependent: :destroy

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
