class UserApplicationSerializer < ActiveModel::Serializer
  attributes :id, :status, :seeker, :resume
  belongs_to :job

  def seeker
    object.user.user_profile.f_name
  end

  def resume
    object.resume.url
  end
end
