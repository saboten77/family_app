class AddBonusesToFamilies < ActiveRecord::Migration[8.1]
  def change
    add_column :families, :family_bonus, :integer
    add_column :families, :role_bonus, :integer
  end
end
