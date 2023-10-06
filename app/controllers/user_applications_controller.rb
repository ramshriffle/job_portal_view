class UserApplicationsController < ApplicationController
  # before_action :check_job_seeker
  before_action :set_param, only: [:show, :destroy, :edit, :update]

  # JobSeeker(current_user) can view his all applied job application
  def index
    @applications=@current_user.user_applications#.page(params[:page]).per(2)
    # render json: seeker_all_applications
  end 
  
  def new
    @user_applications=UserApplication.new
    @job = Job.find_by_id(params[:job_id])
  end

  def show
    @job_application
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

  def update
    debugger
    if @current_user == @job_application.job.user
      if @job_application.update(user_application_param)
        redirect_to root_path
      else
        render json: @job_application.errors.full_messages
      end
    else
      render json: "You have not permission to accept or reject this job application"
    end
  end

  
  def destroy
    if @job_application.destroy
      redirect_to user_applications_path
    else
      render json: @job_application.errors.full_messages
    end
  end
  
  private
  def user_application_param
    params.require(:user_application).permit(:job_id, :status) 
  end
  
  private
  def set_param
    @job_application = UserApplication.find_by_id(params[:id])
    # debugger
  end
end
