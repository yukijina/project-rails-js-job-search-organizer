class ChecklistSerializer < ActiveModel::Serializer
  attributes :id, :position_id, :company_id, :user_id
  belongs_to :user
  belongs_to :position
end
