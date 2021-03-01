class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :name
  has_many :followees, serializer: UserSerializer
  has_many :followers, serializer: UserSerializer
end
