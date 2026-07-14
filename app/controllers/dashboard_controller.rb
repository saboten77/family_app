class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @family = current_user.families.first

    calculator = FamilyEnergyCalculator.new(@family)

    @energy = calculator.call
    @bonus = calculator.role_bonus

    @background = "energy_high"
  end
end
