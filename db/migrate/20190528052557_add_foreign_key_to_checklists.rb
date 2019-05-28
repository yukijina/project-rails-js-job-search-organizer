class AddForeignKeyToChecklists < ActiveRecord::Migration[5.2]
  def change
    add_column :checklists, :company_id, :integer
  end
end
