class CreateRewardCards < ActiveRecord::Migration[8.1]
  def change
    create_table :reward_cards do |t|
      t.string :name, null: false
      t.string :rarity, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
