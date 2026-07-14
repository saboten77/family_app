class RoleSettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @family = current_user.families.first
  end

  def update
  end
end
