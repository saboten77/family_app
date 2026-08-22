class ContactMailer < ApplicationMailer
  def inquiry(name, email, message)
    @name = name
    @email = email
    @message = message

    mail(
      to: "yukidaaayo@gmail.com",
      subject: "【ポン吉のおうち】お問い合わせ"
    )
  end
end
