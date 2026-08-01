class RemoveFamilyBonusFromFamilies < ActiveRecord::Migration[8.1]
  def change
    remove_column :families, :family_bonus, :integer
  end
end
