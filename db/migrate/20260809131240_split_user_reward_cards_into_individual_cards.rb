class SplitUserRewardCardsIntoIndividualCards < ActiveRecord::Migration[8.1]
  def up
    UserRewardCard.reset_column_information

    UserRewardCard.find_each do |card|
      next if card.quantity <= 1

      (card.quantity - 1).times do
        UserRewardCard.create!(
          user_id: card.user_id,
          reward_card_id: card.reward_card_id,
          quantity: 1
        )
      end

      card.update!(quantity: 1)
    end
  end

  def down
    grouped_cards = UserRewardCard
      .group(:user_id, :reward_card_id)
      .having("COUNT(*) > 1")
      .count

    grouped_cards.each do |(user_id, reward_card_id), count|
      cards = UserRewardCard.where(
        user_id: user_id,
        reward_card_id: reward_card_id
      )

      first_card = cards.first
      next unless first_card

      first_card.update!(quantity: count)
      cards.where.not(id: first_card.id).delete_all
    end
  end
end
