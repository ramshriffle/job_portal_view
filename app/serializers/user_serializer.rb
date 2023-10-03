class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :email, :type
  # has_many :jobs
end
