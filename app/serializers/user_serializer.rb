class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :checklists
  has_many :companies
  has_many :positions

end
