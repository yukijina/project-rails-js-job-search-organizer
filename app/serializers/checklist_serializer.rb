class ChecklistSerializer < ActiveModel::Serializer
  attributes :id, :resume, :interview, :completed, :note
end
