class CreateRoleSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :role_settings do |t|
      t.references :family_member, null: false, foreign_key: true
      t.integer :percentage

      t.timestamps
    end
  end
end
