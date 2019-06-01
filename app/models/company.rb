class Company < ApplicationRecord
  has_many :checklists
  has_many :users, through: :checklists
  has_many :positions
  accepts_nested_attributes_for :positions

  validates :name, presence: true, uniqueness: true

  def self.sort_by_name
    Company.order(:name)
  end

  def self.sort_name_desc
    Comapny.order(name: :desc)
  end
end
