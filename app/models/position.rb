class Position < ApplicationRecord
  belongs_to :company
  has_many :checklists

  validates :title, :description, :salary, presence: true

end
