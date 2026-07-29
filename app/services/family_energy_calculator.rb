class FamilyEnergyCalculator
  def initialize(family)
    @family = family
  end

  def call
    @family.energy
  end

  def role_bonus
    0
  end
end
