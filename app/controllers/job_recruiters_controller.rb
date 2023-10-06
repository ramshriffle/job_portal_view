class JobRecruitersController < ApplicationController
  before_action :check_job_recruiter
  before_action :set_job, only: [:index, :filter_application]
  
  #JobRecriuter(current_user) can view all applied job application on a single job
  def index
    if @applications.empty?
      render json: "Nobody apply for job"
    else
      @applications
    end 
  end
  
  # def view_accepted_job_application
  #   applications = @applications.status_accept
  #   if applications.empty?
  #     render json: "You are not accept any job application"
  #   else
  #     render json: applications
  #   end
  # end 

  def filter_application
    @filter = @applications.where(status:params[:status])
    if @filter.empty?
      render json: "You are not accept/reject any job application"
    else
      render json: @filter
    end
  end
  
  # def view_rejected_job_application
  #   applications = @applications.status_reject
  #   if applications.empty?
  #     render json: "You are not reject any job application"
  #   else
  #     render json: applications
  #   end
  # end
  
  private
  def set_job
      @job = Job.find_by_id(params[:job_id])
      @applications = @job.user_applications
  end
end
