class User < ApplicationRecord
  has_secure_password

  has_many :checklists
  has_many :companies, through: :checklists
  has_many :positions, through: :companies

  validates :username, :email, :password, presence: true
  validates :email, uniqueness: true
end
