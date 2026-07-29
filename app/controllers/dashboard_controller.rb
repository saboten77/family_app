class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @family = current_user.families.first

    manager = EnergyManager.new(@family)
    
    @energy = @family.energy
    @bonus_info = manager.bonus_info

    @background =
      case @energy
      when 0...40
        "background4"   # 🏚️ ゴミ屋敷
      when 40...60
        "background3"   # 🌱 少し散らかってる
      when 60...85
        "background2"   # 🏡 きれい
      else
        "background1"   # 🌸 とってもきれい
      end

    positions = [
      { left: "35%", top: "68%" },
      { left: "50%", top: "50%" },
      { left: "65%", top: "68%" },
      { left: "50%", top: "30%" }
    ].shuffle

    @characters = []

    @family_members = @family.family_members.includes(:user)

    @family_members.each_with_index do |member, index|
      last_task_log = member.task_logs.order(created_at: :desc).first

      if last_task_log && last_task_log.created_at > 1.hour.ago
        image = "chara/#{member.user.character || 'character1'}_cleaning.png"
      else
        image = "chara/#{member.user.character || 'character1'}_sleeping.png"
      end

      @characters << {
        image: image,
        position: positions[index]
      }
    end
  end
end
