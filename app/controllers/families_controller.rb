class FamiliesController < ApplicationController
  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)

    if @family.save
       current_user.family_members.create(family: @family)

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
