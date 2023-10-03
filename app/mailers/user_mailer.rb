class UserMailer < ApplicationMailer
  default from: 'ramkrishnak@shriffle.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Job Portal')
  end

  def forgot_password(user)
    @user=user
    mail(to: @user.email, subject: 'Reset password request')
  end
end
