class RoleSettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @family = current_user.families.first

    default_percentage = 100 / @family.family_members.count

    family_members = @family.family_members.includes(:user, :role_setting)

    family_members.each do |member|
      member.create_role_setting(percentage: default_percentage) unless member.role_setting
    end
  end

  def update
    total = params[:roles].values.map(&:to_i).sum

    if total != 100
      redirect_to edit_role_setting_path,
                  alert: "割合の合計を100%にしてください🌱"
      return
    end

    params[:roles].each do |member_id, percentage|
      role_setting = RoleSetting.find_by(family_member_id: member_id)
      role_setting.update!(percentage: percentage)
    end

    redirect_to edit_role_setting_path,
                notice: "🌱 家族のバランスを更新しました！"
  end
end
