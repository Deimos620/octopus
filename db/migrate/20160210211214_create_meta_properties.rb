class CreateMetaProperties < ActiveRecord::Migration
  def change
    create_table :meta_properties do |t|
      t.integer :editor_user_id, default: 1
      t.string :owner_type, index: true
      t.integer :owner_id, index: true
      t.integer :meta_property_category_id, index: true
      t.string :name
      t.string :property
      t.text :content
      t.timestamps null: false
    end
  end
end
