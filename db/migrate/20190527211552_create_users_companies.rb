class CreateUsersCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :users_companies do |t|
      t.integer :user_id
      t.integer :company_id
      t.integer :favorite_rating
    end
  end
end
