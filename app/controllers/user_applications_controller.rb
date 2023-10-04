class UserApplicationsController < ApplicationController
  # before_action :check_job_seeker
  before_action :set_param, only: [:destroy]

  # JobSeeker(current_user) can view his all applied job application
  def index
    seeker_all_applications=@current_user.user_applications.page(params[:page]).per(2)
    render json: seeker_all_applications
  end 
  
  def new
    @user_applications=UserApplication.new
    @job = Job.find_by_id(params[:job_id])
  end
  
  def create
    @user_applications = current_user.user_applications.new(user_application_param) 
    if @user_applications.save
      redirect_to root_path
    else
      render json: @user_applications.errors.full_messages
    end
  end

  def edit
  end
  
  def destroy
    if @user_application.destroy
      render json: {message: "Application withdraw successfully"}
    else
      render json: @user_application.errors.full_messages
    end
  end
  
  private
  def user_application_param
    params.require(:user_application).permit(:job_id, :status) 
  end
  
  private
  def set_param
    @user_application = @current_user.user_applications.find_by_id(params[:id])
    unless @user_application
      render json: "Seeker not applied"
    end
  end
end
