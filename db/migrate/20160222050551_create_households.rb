class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.integer :editor_user_id
      t.integer :importer_user_id
      t.integer :status
      t.string :name,  null: false, default: ""
      t.integer :default_address_id, index: true
      t.string :default_address_name, default: "Home"
      t.string :second_address_name, default: "Home"
      t.integer :second_address_id
      t.timestamps null: false
    end
  end
end
