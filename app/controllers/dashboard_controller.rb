class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @family = current_user.families.first

    calculator = FamilyEnergyCalculator.new(@family)

    @energy = calculator.call
    @bonus = calculator.role_bonus

    @background =
  case @energy
  when 0...25
    "background4"
  when 25...50
    "background3"
  when 50...75
    "background2"
  else
    "background1"
  end
  end
end
