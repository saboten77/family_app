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
  { left: "25%", top: "60%" },
  { left: "50%", top: "65%" },
  { left: "75%", top: "60%" },
  { left: "35%", top: "45%" },
  { left: "65%", top: "45%" }
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
