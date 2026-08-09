class AddRequesterUserToRewardRequests < ActiveRecord::Migration[8.1]
  def change
    add_reference :reward_requests,
                  :requester_user,
                  foreign_key: { to_table: :users }
  end
end
