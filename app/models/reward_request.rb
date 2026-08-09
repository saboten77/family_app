class RewardRequest < ApplicationRecord
  belongs_to :user

  belongs_to :requester_user,
             class_name: "User",
             optional: true

  belongs_to :reward_card

  belongs_to :user_reward_card,
             optional: true

  belongs_to :completed_by_user,
             class_name: "User",
             optional: true

  validates :status, presence: true
end
