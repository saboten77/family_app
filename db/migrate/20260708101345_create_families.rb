class CreateFamilies < ActiveRecord::Migration[8.1]
  def change
    create_table :families do |t|
      t.string :name
      t.string :invite_code

      t.timestamps
    end
  end
end
