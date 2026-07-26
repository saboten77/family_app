class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def edit
  end

  def update
  if @user.update(profile_params)
    redirect_to account_profile_path, notice: "プロフィールを更新しました🌱"
  else
    render :edit, status: :unprocessable_entity
  end
  end

  def select_character
  if request.patch?
    if @user.update(character: params[:character])
      redirect_to profile_select_character_path,
                  notice: "キャラクターを設定しました🐾"
    end
  end
  end

  def change_character
  if request.patch?
    if @user.update(character: params[:character])
      redirect_to account_profile_path, notice: "キャラクターを変更しました🐾"
    end
  end
end

  private

  def set_user
    @user = current_user
  end

  def profile_params
    params.require(:user).permit(:name, :character)
  end
end
