class CreateBlogPosts < ActiveRecord::Migration

  def change
    create_table :blog_posts do |t|
        t.string :title
        t.integer :editor_user_id, default: 1
        t.integer :blog_author_id, index: true
        t.integer :original_post_id
        t.integer :blog_editor_user_id
        t.string :type, null: false, default: ""
        t.integer :blog_section_id, index: true
        t.integer :blog_feature_id, index: true
        t.string :lead
        t.text :body
        t.datetime :published_datetime
        t.integer :status, index: true, default: 0 
        t.string :hero_img
        t.string :hero_caption
        t.string :thumbnail_img
        t.string :slug, index: true
        t.boolean :special, default: false

      t.timestamps null: false
    end
  end
end
