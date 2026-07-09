class AddProfileToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :nickname, :string
    add_column :users, :character, :string
  end
end
