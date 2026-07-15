class FamilyEnergyCalculator
  TARGET_TASKS_PER_DAY = 11
  TASK_ENERGY = 60

  def initialize(family)
    @family = family
  end

  def call
    energy = today_task_energy

    energy += role_bonus

    energy
  end

  def role_bonus
  0
  end

  private

  def today_task_energy
    task_count = today_task_logs.count

    energy = task_count.to_f / TARGET_TASKS_PER_DAY * TASK_ENERGY

    [ energy, TASK_ENERGY ].min
  end

  def today_task_logs
    @family.family_members
           .flat_map(&:task_logs)
           .select do |log|
             log.completed_at.to_date == Date.current
           end
  end
end
