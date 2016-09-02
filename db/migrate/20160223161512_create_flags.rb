class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.integer :editor_contact_id
      t.string :owner_type
      t.integer :owner_id
      t.string :secondary_owner_type
      t.integer :secondary_owner_id
      t.string :category
      t.string :note
      t.integer :status
      t.boolean :critical, default: false
      t.timestamps null: false
    end
  end
end
