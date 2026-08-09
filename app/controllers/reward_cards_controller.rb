class RewardCardsController < ApplicationController
  def index
    # 自分が持っているカード
    @user_reward_cards =
      current_user.user_reward_cards.includes(:reward_card)

    # 自分が所属している家族
    current_family =
      current_user.family_members.includes(:family).first&.family

    # 家族メンバーのユーザーID
    family_member_user_ids =
      current_family&.family_members
                   &.pluck(:user_id) || []

    # 家族から届いている未完了の依頼
    @reward_requests =
      RewardRequest
        .where(user_id: family_member_user_ids, status: "pending")
        .includes(:user, :reward_card)

    # 自分が家族に依頼中のご褒美
    @my_reward_requests =
      RewardRequest
        .where(
          requester_user_id: current_user.id,
          status: "pending"
        )
        .includes(:reward_card)
  end

  def confirm
    @reward_request = RewardRequest.find(params[:id])
  end

  def complete
    reward_request = RewardRequest.find(params[:id])

    reward_request.update!(
      status: "completed",
      completed_by_user_id: current_user.id,
      completed_at: Time.current
    )

    redirect_to reward_cards_path
  end

  def use_confirm
    @user_reward_card =
      current_user.user_reward_cards.find(params[:id])

    @reward_card = @user_reward_card.reward_card
  end
end
