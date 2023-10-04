class JobRecruitersController < ApplicationController
  before_action :check_job_recruiter
  before_action :set_param, only: [:accept_or_reject_job_application]
  before_action :job_set, only: [:index]
  
  #JobRecriuter(current_user) can view all applied job application
  #on his particular job
  def index
    # debugger
    if @job.user_applications.empty?
      render json: "Nobody apply for job"
    else
      render json:@job.user_applications
    end
  end
  
  def accept_or_reject_job_application
    if @current_user == @application.job.user
      if @application.update(status:params[:status])
        render json: @application
      else
        render json: @application.errors.full_messages
      end
    else
      render json: "You have not permission to accept or reject this job application"
    end
  end
  
  def view_accepted_job_application
    applications = @applied_applications.status_accept
    if applications.empty?
      render json: "You are not accept any job application"
    else
      render json: applications
    end
  end 
  
  def view_rejected_job_application
    applications = @applied_applications.status_reject
    if applications.empty?
      render json: "You are not reject any job application"
    else
      render json: applications
    end
  end
  
  private
  def set_param
    @application= UserApplication.find_by_id(params[:id])
    unless @application
      render json: "Job Application not Found"
    end
  end
  
  private
  def job_set
    debugger
      @job = Job.find_by_id(params[:job_id])
  
  end
end
