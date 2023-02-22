class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Честитки за комплетирањето на вашиот профил на Cargster.co")
  end
end
