class JobSerializer < ActiveModel::Serializer
  attributes :id, :job_title, :description, :salary, :location, :recruiter_name
  # belongs_to :user

  def recruiter_name
    object.user.user_profile.f_name
  end
end
