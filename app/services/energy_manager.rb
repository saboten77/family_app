class EnergyManager
  TASK_ENERGY = 2

  def initialize(family)
    @family = family
  end

  # 家事を1件登録したら呼ばれる
  def add_task_energy
    energy = @family.energy || 60

    energy += TASK_ENERGY

    @family.update!(
      energy: [ energy, 100 ].min
    )
  end

  # 毎日0時にCron Jobから呼ぶ
  def daily_update
  energy = @family.energy

  energy += family_bonus
  energy += role_bonus
  energy -= 10

  energy = [ [ energy, 0 ].max, 100 ].min

  unless @family.update(energy: energy)
    puts @family.errors.full_messages
  end
end

  def bonus_info
  {
    family_bonus: family_bonus,
    role_bonus: role_bonus
  }
  end

  private

  def family_bonus
  members = today_task_logs.map(&:family_member_id).uniq.count
  total_members = @family.family_members.count

  participation_rate = members.to_f / total_members * 100

  case participation_rate
  when 100
    40
  when 67..99
    30
  when 50..66
    20
  else
    0
  end
  end

  def role_bonus
  logs = today_task_logs

  return 0 if logs.empty?

  total_tasks = logs.count

  differences = @family.family_members.map do |member|
    setting = member.role_setting

    next unless setting

    # 家族メンバーごとの実際の家事割合を計算
    #
    # 計算式：
    # 実績割合(%) = 担当した家事数 ÷ 家族全体の家事数 × 100
    #
    # 例：
    # Aさん 5件、家族全体10件の場合
    # 5 ÷ 10 × 100 = 50%
    actual_count = logs.count do |log|
      log.family_member_id == member.id
    end

    actual_percentage = actual_count.to_f / total_tasks * 100

    # 目標割合との差を計算
    #
    # 計算式：
    # ズレ(%) = |実績割合 - 設定割合|
    #
    # 例：
    # 設定50%、実績60%の場合
    # |60 - 50| = 10%
    (actual_percentage - setting.percentage).abs
  end.compact

  return 0 if differences.empty?

  # 家族内で一番大きい割合のズレを基準にする
  max_difference = differences.max

  # 役割バランスボーナス
  #
  # ズレが小さいほど「協力できている」と判断して
  # エネルギーを追加する
  #
  # 0〜10%   : バランス最高！ +30
  # 11〜25%  : いい感じ！    +20
  # 26〜40%  : 少し偏りあり  +10
  # 41%以上  : 調整中        +0
  case max_difference
  when 0..10
    30
  when 11..25
    20
  when 26..40
    10
  else
    0
  end
end

  def today_task_logs
  @family.family_members
         .includes(:role_setting, :task_logs)
         .flat_map(&:task_logs)
         .select do |log|
           log.completed_at.to_date == Date.current
         end
  end

end
