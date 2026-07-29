class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def edit_password
  end

  def update_email
  if @user.update(email_params)
    bypass_sign_in(@user)

    redirect_to account_path,
      notice: "メールアドレスを変更しました📮✨"
  else
    render :edit_email,
      status: :unprocessable_entity
  end
  end

  def update_profile
    if @user.update(profile_params)
      redirect_to dashboard_path, notice: "プロフィールを更新しました🌱"
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  def update_password
    if @user.valid_password?(password_params[:current_password])

      if @user.update(password_params.except(:current_password))
        bypass_sign_in(@user)

        redirect_to account_path,
          notice: "パスワードを変更しました🐻✨"
      else
        render :edit_password,
          status: :unprocessable_entity
      end

    else
      @user.errors.add(
      :base,
      "現在のパスワードが正しくありません"
    )

      render :edit_password,
        status: :unprocessable_entity
    end
  end


  private

  def set_user
    @user = current_user
  end

  def password_params
    params.require(:user).permit(
      :current_password,
      :password,
      :password_confirmation
    )
  end

  def profile_params
    params.require(:user).permit(:name)
  end
end

 def email_params
  params.require(:user).permit(:email)
 end
