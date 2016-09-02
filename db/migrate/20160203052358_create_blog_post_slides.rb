class CreateBlogPostSlides < ActiveRecord::Migration
  def change
    create_table :blog_post_slides do |t|
      t.references :blog_post, index: true
      t.integer :editor_user_id, default: 1
      t.integer :blog_author_id
      t.integer :blog_editor_user_id
      t.integer :rank, default: 1000
      t.string :title
      t.text :description
      t.references :blog_image
      t.integer :orientation, default: 1
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
