class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :editor_user_id
      t.string :title
      t.string :slug, index: true
      t.timestamps null: false
    end
  end
end
