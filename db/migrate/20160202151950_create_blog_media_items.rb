class CreateBlogMediaItems < ActiveRecord::Migration
  def change
    create_table :blog_images do |t|
      t.integer :editor_user_id, default: 1
      t.string :type, default: "PhotoMediaItem"
      t.string :landscape_image
      t.string :portrait_image
      t.string :thumbnail_image
      t.string :title
      t.string :description
      t.string :caption
      t.integer :status, index: true
      t.integer :license
      t.boolean :octopus_owned, default: false
      t.string :owner_name
      t.string :owner_link
      t.string :owner_site_name
      t.string :media_link
      t.text :note
      
      t.timestamps null: false
    end
  end
end
