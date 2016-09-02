class CreateBlogCategories < ActiveRecord::Migration
  def change
    create_table :blog_categories do |t|
      t.integer :editor_user_id
      t.string :name, index: true
      t.string :slug, index: true
      t.string :hero
      t.string :thumbnail
      t.string :description
      t.integer :editor_user_id, default: 1
      t.integer :rank, default: 1000
      t.timestamps null: false
    end
  end
end
