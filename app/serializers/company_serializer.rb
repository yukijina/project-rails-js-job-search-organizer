class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :description
  has_many :positions
  has_many :users
end
