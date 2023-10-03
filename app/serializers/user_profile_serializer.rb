class UserProfileSerializer < ActiveModel::Serializer
  attributes :id, :f_name, :l_name, :education, :skills, :experience, :image

  def image
    object.image.url
  end
end
