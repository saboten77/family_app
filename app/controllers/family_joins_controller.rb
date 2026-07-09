class FamilyJoinsController < ApplicationController
  def new
  end

  def create
    family = Family.find_by(invite_code: params[:invite_code])

    if family
      current_user.update(family: family)
      redirect_to dashboard_path, notice: "家族に参加しました！"
    else
      flash.now[:alert] = "招待コードが見つかりません"
      render :new, status: :unprocessable_entity
    end
  end
end