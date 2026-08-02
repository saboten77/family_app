class AddPointsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :points, :integer, default: 0, null: false
  end
end
