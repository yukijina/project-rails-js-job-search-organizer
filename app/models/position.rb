class Position < ApplicationRecord
  belongs_to :company
  has_many :checklists
  accepts_nested_attributes_for :company

  validates :title, :description, :salary, presence: true

  def self.sort_by_title
    order('LOWER(title)')
  end

end
