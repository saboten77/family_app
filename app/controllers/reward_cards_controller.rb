class RewardCardsController < ApplicationController
  def index
    # =========================
    # 自分が持っているご褒美カード
    # =========================
    @user_reward_cards =
      current_user.user_reward_cards.includes(:reward_card)

    # =========================
    # 自分が所属している家族
    # =========================
    current_family =
      current_user.family_members.includes(:family).first&.family

    # =========================
    # 自分以外の家族メンバー
    # =========================
    family_member_user_ids =
      current_family&.family_members
                   &.where.not(user_id: current_user.id)
                   &.pluck(:user_id) || []

    # =========================
    # 自分に届いている依頼
    # =========================
    @reward_requests =
      RewardRequest
        .where(
          user_id: current_user.id,
          status: "pending"
        )
        .includes(
          :requester_user,
          :reward_card
        )

    # =========================
    # 自分が家族に依頼中のもの
    # =========================
    @my_reward_requests =
      RewardRequest
        .where(
          requester_user_id: current_user.id,
          user_id: family_member_user_ids
        )
  end

  # =========================
  # 家族から届いた依頼の確認画面
  # =========================

  def confirm
  @reward_request =
    current_user.reward_requests
                .includes(:requester_user, :reward_card)
                .find(params[:id])
  end


# =========================
# みんなOKになったカードの確認画面
# =========================

def approved
  @user_reward_card =
    current_user.user_reward_cards
                .includes(:reward_card)
                .find(params[:id])

  @reward_card = @user_reward_card.reward_card
end


# =========================
# 「ありがとう！」でカードを消費
# =========================

def destroy_approved
  user_reward_card =
    current_user.user_reward_cards.find(params[:id])

  reward_requests =
    RewardRequest.where(
      requester_user_id: current_user.id,
      user_reward_card_id: user_reward_card.id
    )

  # 依頼が存在しない場合は削除させない
  if reward_requests.empty?
    redirect_to reward_cards_path,
      alert: "このご褒美はまだ使えないよ🐹"
    return
  end

  # 家族全員がOKしているか確認
  unless reward_requests.all? { |request| request.status == "completed" }
    redirect_to reward_cards_path,
      alert: "まだ家族全員のOKが揃っていないよ💌"
    return
  end

  # この1枚に紐づく依頼を先に削除
  reward_requests.destroy_all

  # この1枚だけ削除
  user_reward_card.destroy!

  redirect_to reward_cards_path,
    notice: "💛 ご褒美を使ったよ！"
end


  # =========================
  # ご褒美依頼を完了する
  # =========================
  def complete
    reward_request =
      current_user.reward_requests.find(params[:id])

    reward_request.update!(
      status: "completed",
      completed_by_user_id: current_user.id,
      completed_at: Time.current
    )

    redirect_to reward_cards_path,
      notice: "🎉 ご褒美依頼をOKしたよ！"
  end

  # =========================
  # 自分のご褒美カードを使う確認画面
  # =========================
  def use_confirm
    @user_reward_card =
      current_user.user_reward_cards
                  .includes(:reward_card)
                  .find(params[:id])

    @reward_card =
      @user_reward_card.reward_card
  end
end
