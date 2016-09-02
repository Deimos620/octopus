class CreateBlogPostCategories < ActiveRecord::Migration
  def change
    create_table :blog_post_categories do |t|
        t.references :blog_category, index: true
        t.references :blog_post, index: true
        t.integer :rank
        t.integer :editor_user_id, default: 1
      t.timestamps null: false
    end
  end
end
