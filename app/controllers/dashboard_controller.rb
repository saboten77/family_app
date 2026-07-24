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

    positions = [
  { left: "12%", top: "72%" },
  { left: "28%", top: "58%" },
  { left: "50%", top: "72%" },
  { left: "72%", top: "58%" },
  { left: "88%", top: "72%" },
  { left: "18%", top: "40%" },
  { left: "50%", top: "32%" },
  { left: "82%", top: "40%" }
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
