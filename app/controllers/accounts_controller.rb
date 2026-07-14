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

  private

  def set_user
    @user = current_user
  end
end
