class AddUserRewardCardToRewardRequests < ActiveRecord::Migration[8.1]
  def change
    add_reference :reward_requests,
                  :user_reward_card,
                  null: true,
                  foreign_key: true
  end
end
