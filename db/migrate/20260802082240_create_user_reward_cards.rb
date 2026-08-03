class CreateUserRewardCards < ActiveRecord::Migration[8.1]
  def change
    create_table :user_reward_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reward_card, null: false, foreign_key: true
      t.integer :quantity, default: 1, null: false

      t.timestamps
    end
  end
end
