class Company < ApplicationRecord
  has_many :checklists
  has_many :users, through: :checklists
  has_many :positions
  accepts_nested_attributes_for :positions

  validates :name, :url, presence: true, uniqueness: true

  def self.sort_by_name
    order('LOWER(name)')
  end

end
