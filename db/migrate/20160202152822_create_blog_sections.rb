class CreateBlogSections < ActiveRecord::Migration
  def change
    create_table :blog_sections do |t|
      t.integer :editor_user_id, default: 1
      t.string :title
      t.text :description
      t.string :hero_img
      t.string :thumbnail_img
      t.boolean :live, default: true
      t.string :slug, index: true
      
      t.timestamps null: false
    end
  end
end
