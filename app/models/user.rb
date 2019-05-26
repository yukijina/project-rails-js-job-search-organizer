class User < ApplicationRecord
  has_secure_password

  has_many :companies
  has_many :positions, through: :companies
  has_many :checklists
end
