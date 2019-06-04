class User < ApplicationRecord
  has_secure_password

  has_many :checklists
  has_many :companies, through: :checklists
  has_many :positions, through: :checklists

  validates :username, :email, :password, presence: true
  validates :email, uniqueness: true

  def self.from_omniauth(auth)
    #Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.username = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex
    end
  end

  def find_positions(id)
    self.positions.where(company_id: id)
  end


  # def self.sort_by_name(current_user)
  #   find(current_user.id).companies.order(name: :asc).map do |company|
  #     company
  #   end
  # end

end
