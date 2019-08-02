class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :url
  has_many :positions
  has_many :users
end
