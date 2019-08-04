class PositionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :salary, :full_time, :created_at, :updated_at, :company_id
  belongs_to :company

  # def company
  #   binding.pry
  #    id = self.object.company_id
  #    { company_id: id,
  #      name: Company.find_by(id: id).name  }
   #end
end
