class PositionSerializer < ActiveModel::Serializer
  attributes :id, :description, :salary, :full_time
  belongs_to :company
end
