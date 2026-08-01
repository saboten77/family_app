class AddLastEnergyUpdatedOnToFamilies < ActiveRecord::Migration[8.1]
  def change
    add_column :families, :last_energy_updated_on, :date
  end
end
