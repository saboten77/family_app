class AddFamilyToUsers < ActiveRecord::Migration[8.1]
  def change
    add_reference :users, :family, foreign_key: true
  end
end
