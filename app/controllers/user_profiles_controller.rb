class UserProfilesController < ApplicationController
  before_action :check_for_existing_profile, only: [:create]
  before_action :set_param, only: [:show, :update, :destroy, :edit]
  
  def show
    @user_profile
  end

  def new

  end
  
  def create
    @profile = @current_user.build_user_profile(user_profile_param)
    if @profile.save 
      redirect_to user_profiles_path
    else
      render json: @profile.errors.full_messages
    end 
  end

  def edit
    
  end
  
  def update
    if @user_profile.update(user_profile_param)
      redirect_to user_profiles_path
    else
      render json: { errors: @user_profile.full_messages}
    end
  end
  
  def destroy
    if @user_profile.destroy
      redirect_to root_path
    else
      render json: { errors: @user_profile.errors.full_messages }
    end
  end
  
  private
  def user_profile_param
    params.require(:user_profile).permit(:f_name, :l_name, :skills, :experience, :education, :image)
  end
  
  private
  def check_for_existing_profile
    unless @current_user.user_profile.nil?
      render json: 'You have already created profile'
    end
  end

  private
  def set_param
    @user_profile=@current_user.user_profile
    if @user_profile.nil?
      redirect_to new_user_profiles_path
    end
  end
end
