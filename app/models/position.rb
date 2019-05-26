class Position < ApplicationRecord
  belings_to :company
  has_many :users
  has_many :checklists
end
