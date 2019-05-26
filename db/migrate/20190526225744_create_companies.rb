class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :city
      t.string :contact_person
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
