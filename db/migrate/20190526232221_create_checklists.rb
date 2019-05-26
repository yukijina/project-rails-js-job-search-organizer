class CreateChecklists < ActiveRecord::Migration[5.2]
  def change
    create_table :checklists do |t|
      t.integer :user_id
      t.integer :position_id
      t.boolean :resume, null: false, default: false
      t.boolean :interview, null: false, default: false
      t.boolean :completed, null: false, default: false
      t.string :note

      t.timestamps
    end
  end
end
