class PasswordsController < ApplicationController
  skip_before_action :authenticate_request
  
  def forgot_password
    user = User.find_by(email: params[:email]) # if present find user by email
    if user.present?
      user.generate_password_token! #generate pass token

      UserMailer.forgot_password(user).deliver_now
      render json: "mail successfully send for reset password"
    else
      render json: {error: "Email address not found. Please check and try again"}, status: :not_found
    end
  end
  
  def reset_password
    token = params[:token]
    user = User.find_by(reset_password_token: token)
    
    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: "password changed successfully!!"
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  "token not valid or expired. Try generate a new token"}, status: :not_found
    end
  end
end
