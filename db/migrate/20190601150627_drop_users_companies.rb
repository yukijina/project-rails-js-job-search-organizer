class DropUsersCompanies < ActiveRecord::Migration[5.2]
  def change
    drop_table :users_companies
  end
end
