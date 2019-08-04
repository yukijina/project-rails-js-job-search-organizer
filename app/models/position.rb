class Position < ApplicationRecord
  belongs_to :company
  has_many :checklists
  accepts_nested_attributes_for :company

  validates :title, :description, :salary, presence: true

end
