class ConfMailer < ApplicationMailer
  default from: 'no-reply@university-tracker.com'

  def send_conf_email(user)
    @user = user
    @url = "http://localhost:3000/users/mail_auth?conf=#{@user.confirm_code}"
    mail(to: @user.email, subject: "Account Verification")
  end
end
