class ContactsController < ApplicationController
  def new
  end

  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]

    if name.blank? || email.blank? || message.blank?
      flash.now[:alert] = "すべての項目を入力してください"
      render :new, status: :unprocessable_entity
      return
    end

    ContactMailer.inquiry(name, email, message).deliver_now

    redirect_to new_contact_path, notice: "お問い合わせを送信しました📩"
  rescue StandardError
    redirect_to new_contact_path,
                alert: "お問い合わせの送信に失敗しました。時間をおいて再度お試しください。"
  end
end
