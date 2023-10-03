class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name,:type])
  end
  
  def check_job_recruiter
    unless @current_user.type == 'JobRecruiter'
      render json: { message: "You are not Recruiter" } 
    end
  end
  
  def check_job_seeker
    unless @current_user.type == 'JobSeeker'
      render json: { message: "You are not Seeker" } 
    end
  end
end
