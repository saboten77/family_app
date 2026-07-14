class AddDefaultAndNullToRoleSettingsPercentage < ActiveRecord::Migration[8.1]
  def change
    change_column_default :role_settings, :percentage, 50
    change_column_null :role_settings, :percentage, false
  end
end
