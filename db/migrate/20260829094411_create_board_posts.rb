class CreateBoardPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :board_posts do |t|
      t.references :family_member, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
