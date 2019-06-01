class RemoveCityContactPersonEmailPhoneNumberFromCompanies < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :city, :string
    remove_column :companies, :contact_person, :string
    remove_column :companies, :email, :string
    remove_column :companies, :phone_number, :string
  end
end
