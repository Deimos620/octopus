class CreateMetaPropertyCategories < ActiveRecord::Migration
  def change
    create_table :meta_property_categories do |t|
      t.integer :editor_user_id, default: 1
      t.integer :kind, index: true
      t.integer :label, index: true
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
