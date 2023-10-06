class JobsController < ApplicationController
  # before_action :check_job_recruiterss, except: [:index]
  before_action :set_param, only: [:show,:update, :destroy, :edit]
  
  def index
    if @current_user.type == "JobRecruiter"
      @jobs = @current_user.jobs
    else
      @jobs = Job.all
    end
  end
  
  def new
  end
  
  def show
    @job
  end
  
  def create
    # debugger
    @job = @current_user.jobs.new(job_param)
    if @job.save
      redirect_to @job
    else
      render json: @job.errors.full_messages
    end  
  end
  
  def edit 
  end
  
  def update 
    if @job.update(job_param)
      redirect_to job_path(@job)
      render json: @job.errors.full_messages
    end 
  end
  
  def destroy
    if @job.destroy
      redirect_to root_path
    else
      render json: @job.errors.full_messages
    end 
  end
  
  private
  def job_param
    # debugger
    params.require(:job).permit(:job_title, :description, :location, :salary)
  end
  
  private
  def set_param
    @job= Job.find_by_id(params[:id])
    unless @job
      render json: "Job not Found"
    end
  end
end
