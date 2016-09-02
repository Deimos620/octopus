class CreateBlogSelectedImages < ActiveRecord::Migration
  def change
    create_table :blog_selected_images do |t|
      t.references :blog_post, index: true
      t.references :blog_media_item, index: true
      t.timestamps null: false
    end
  end
end
