class GachaController < ApplicationController
  def show
    if session[:gacha_reward_card_id]
      @reward_card = RewardCard.find_by(
        id: session.delete(:gacha_reward_card_id)
      )
    end
  end

  def draw
    result = GachaManager.new(current_user).draw

    if result[:success]
      session[:gacha_reward_card_id] = result[:reward_card].id
      redirect_to gacha_path
    else
      redirect_to gacha_path, alert: result[:message]
    end
  end
end
