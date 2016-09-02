class CreateBlogFeatures < ActiveRecord::Migration
  def change
    create_table :blog_features do |t|
      t.integer :editor_user_id, default: 1
      t.string :title, index: true
      t.text :description
      t.string :hero_img
      t.string :thumbnail_img
      t.string :slug, index: true
      t.boolean :live, default: true
      t.string :hashtag
      
      t.timestamps null: false
    end
  end
end
