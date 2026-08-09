class GachaManager
  GACHA_COST = 30

  RARITY_RATES = {
    "SSR" => 5,
    "SR" => 15,
    "R" => 30,
    "N" => 50
  }.freeze

  def initialize(user)
    @user = user
  end

  def draw
    return { success: false, message: "ポイントが足りません" } if @user.points < GACHA_COST

    rarity = draw_rarity
    reward_card = RewardCard.where(rarity: rarity).sample

    if reward_card.nil?
      return { success: false, message: "カードが見つかりません" }
    end

    @user.with_lock do
      @user.update!(points: @user.points - GACHA_COST)

      user_reward_card = @user.user_reward_cards.find_or_initialize_by(
        reward_card: reward_card
      )

      if user_reward_card.new_record?
        user_reward_card.quantity = 1
      else
        user_reward_card.quantity += 1
      end

      user_reward_card.save!
    end

    {
      success: true,
      reward_card: reward_card
    }
  end

  private

  def draw_rarity
    random_number = rand(100)

    case random_number
    when 0...5
      "SSR"
    when 5...20
      "SR"
    when 20...50
      "R"
    else
      "N"
    end
  end
end
