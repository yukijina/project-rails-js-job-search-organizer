class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :title
      t.string :description
      t.integer :salary
      t.boolean :full_time, null: false, default: false
      t.integer :company_id

      t.timestamps
    end
  end
end
