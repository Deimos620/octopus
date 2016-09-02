class CreateRestrictions < ActiveRecord::Migration
  def change
    create_table :restrictions do |t|
      t.integer :kind, default: 1, index: true
      t.string :name
      t.string :note
      t.integer :editor_user_id, default: 1
      t.boolean :visible, default: true
      t.integer :rank, default: 99
      t.timestamps null: false
    end
  end
end
