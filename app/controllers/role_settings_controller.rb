class RoleSettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @family = current_user.families.first

    @family.family_members.each do |member|
      member.create_role_setting(percentage: 50) unless member.role_setting
    end
  end

  def update
    params[:roles].each do |member_id, percentage|
      role_setting = RoleSetting.find_by(family_member_id: member_id)
      role_setting.update!(percentage: percentage)
    end

    redirect_to edit_role_setting_path, notice: "🌱 家族のバランスを更新しました！"
  end
end
