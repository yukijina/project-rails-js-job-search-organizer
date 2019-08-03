class PositionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :salary, :full_time, :created_at, :updated_at, :company_id
  belongs_to :company
end
