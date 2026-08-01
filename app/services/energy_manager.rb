class EnergyManager
  TASK_ENERGY = 2

  def initialize(family)
    @family = family
  end

  # 家事を1件登録したときに呼ばれる
  def add_task_energy
    energy = @family.energy || 60

    # 現在の役割ボーナス（%）を計算
    current_role_bonus = role_bonus

    # 基本エネルギーに役割ボーナスを加える
    # 例：2エネルギー + 30% → 2 × 1.3 = 2.6
    earned_energy = TASK_ENERGY * (1 + current_role_bonus / 100.0)

    energy += earned_energy.round

    energy = [ [ energy, 0 ].max, 100 ].min

    @family.update!(
      energy: energy,
      role_bonus: current_role_bonus
    )
  end

  # 1日1回、家庭エネルギーを10減らす
  def daily_update
    return if @family.last_energy_updated_on == Date.current

    energy = @family.energy || 60
    energy -= 10
    energy = [ [ energy, 0 ].max, 100 ].min

    @family.update!(
      energy: energy,
      last_energy_updated_on: Date.current
    )
  end

  # 現在の役割ボーナス情報
  def bonus_info
    {
      role_bonus: role_bonus
    }
  end

  private

  # 家事の役割バランスに応じたボーナス（%）
  def role_bonus
    logs = today_task_logs

    return 0 if logs.empty?

    total_tasks = logs.count

    differences = @family.family_members.map do |member|
      setting = member.role_setting

      next unless setting

      # 実際に担当した家事の割合
      actual_count = logs.count do |log|
        log.family_member_id == member.id
      end

      actual_percentage = actual_count.to_f / total_tasks * 100

      # 設定された役割割合との差
      (actual_percentage - setting.percentage).abs
    end.compact

    return 0 if differences.empty?

    max_difference = differences.max

    # ズレが小さいほど、獲得エネルギーが増える
    case max_difference
    when 0..10
      30  # +30%
    when 11..25
      20  # +20%
    when 26..40
      10  # +10%
    else
      0   # +0%
    end
  end

  # 今日の家事記録を取得
  def today_task_logs
    @family.family_members
           .includes(:task_logs, :role_setting)
           .flat_map(&:task_logs)
           .select do |log|
             log.completed_at.to_date == Date.current
           end
  end
end
