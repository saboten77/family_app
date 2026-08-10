class FamiliesController < ApplicationController
  def index
    @family = current_user.families.first

    if @family
      @family_members = @family.family_members.includes(:user)
    end
  end

  def new
    if current_user.family_members.exists?
      redirect_to dashboard_path,
                  alert: "すでに家族に所属しています🐹"
      return
    end

    @family = Family.new
  end

  def create
    if current_user.family_members.exists?
      redirect_to dashboard_path,
                  alert: "すでに家族に所属しています🐹"
      return
    end

    @family = Family.new(family_params)

    if @family.save
      current_user.family_members.create!(family: @family)

      redirect_to family_invite_path(@family)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
