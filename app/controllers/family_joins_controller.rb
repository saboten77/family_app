class FamilyJoinsController < ApplicationController
  def new
    if current_user.family_members.exists?
      redirect_to dashboard_path,
        alert: "すでに家族に所属しています🐹"
    end
  end

  def create
    if current_user.family_members.exists?
      redirect_to dashboard_path,
        alert: "すでに家族に所属しています🐹"
      return
    end

    family = Family.find_by(invite_code: params[:invite_code])

    if family
      current_user.family_members.create!(family: family)

      redirect_to dashboard_path,
        notice: "家族に参加しました！"
    else
      flash.now[:alert] = "招待コードが見つかりません"
      render :new, status: :unprocessable_entity
    end
  end
end
