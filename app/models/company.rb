class Company < ApplicationRecord
  has_many :users_companies
  has_many :users, through: :users_companies
  has_many :positions
  accepts_nested_attributes_for :positions

  validates :name, presence: true
end
