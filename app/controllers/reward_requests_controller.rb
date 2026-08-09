class RewardRequestsController < ApplicationController
  def create
    reward_card = RewardCard.find(params[:reward_card_id])

    # 依頼を受ける家族を取得
    current_family =
      current_user.family_members.includes(:family).first&.family

    family_member_user_ids =
      current_family&.family_members
                   &.where.not(user_id: current_user.id)
                   &.pluck(:user_id) || []

    # 今はテスト用に、家族が自分1人でも依頼を作れるようにする
    recipient_user_id =
      family_member_user_ids.first || current_user.id

    RewardRequest.create!(
      user_id: recipient_user_id,
      requester_user_id: current_user.id,
      reward_card_id: reward_card.id,
      status: "pending"
    )

    redirect_to reward_cards_path,
      notice: "💌 家族にご褒美をお願いしたよ！"
  end
end
