class RewardRequestsController < ApplicationController
  def create
    # =========================
    # 自分が持っている「この1枚」を取得
    # =========================
    user_reward_card =
      current_user.user_reward_cards
                  .includes(:reward_card)
                  .find(params[:user_reward_card_id])

    reward_card = user_reward_card.reward_card

    # =========================
    # 自分が所属している家族
    # =========================
    current_family =
      current_user.family_members.includes(:family).first&.family

    # 家族がいなければ戻す
    unless current_family
      redirect_to reward_cards_path,
        alert: "家族に所属していないよ🐹"
      return
    end

    # =========================
    # 自分以外の家族メンバー
    # =========================
    family_member_user_ids =
      current_family.family_members
                   .where.not(user_id: current_user.id)
                   .pluck(:user_id)

    # =========================
    # 家族全員に依頼
    # =========================
    family_member_user_ids.each do |user_id|
      RewardRequest.create!(
        user_id: user_id,
        requester_user_id: current_user.id,
        reward_card_id: reward_card.id,
        user_reward_card_id: user_reward_card.id,
        status: "pending"
      )
    end

    redirect_to reward_cards_path,
      notice: "💌 家族にご褒美をお願いしたよ！"
  end
end
