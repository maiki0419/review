class ContactMailer < ApplicationMailer
  def send_mail(user,title,content)
    @user = user
    @title = title
    @content = content
    mail to: user.email,subject: title
  end
end
