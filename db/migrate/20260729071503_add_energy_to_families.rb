class AddEnergyToFamilies < ActiveRecord::Migration[8.1]
  def change
    add_column :families, :energy, :integer, default: 60, null: false
  end
end
