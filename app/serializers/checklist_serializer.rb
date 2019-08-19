class ChecklistSerializer < ActiveModel::Serializer
  attributes :id, :resume, :interview, :completed, :note
  belongs_to :user
  belongs_to :position
end
