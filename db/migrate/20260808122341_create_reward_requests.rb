class CreateRewardRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :reward_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reward_card, null: false, foreign_key: true
      t.string :status, null: false, default: "pending"
      t.bigint :completed_by_user_id
      t.datetime :completed_at

      t.timestamps
    end

    add_foreign_key :reward_requests, :users, column: :completed_by_user_id
  end
end
