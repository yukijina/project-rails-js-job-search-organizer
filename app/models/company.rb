class Company < ApplicationRecord
  has_many :users
  has_many :positions

  validates :name, presence: true
end
