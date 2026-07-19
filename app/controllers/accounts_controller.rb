class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def edit_profile
  end

  def edit_email
  end

  def edit_password
  end

  def update_profile
  if @user.update(profile_params)
    redirect_to dashboard_path, notice: "プロフィールを更新しました🌱"
  else
    render :edit_profile, status: :unprocessable_entity
  end
  end

  private

  def set_user
    @user = current_user
  end
end

  def profile_params
  params.require(:user).permit(:name)
  end
