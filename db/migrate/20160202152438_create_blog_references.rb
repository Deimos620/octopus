class CreateBlogReferences < ActiveRecord::Migration
  def change
    create_table :blog_references do |t|
      t.references :blog_post, index: true
      t.integer :editor_user_id, default: 1
      t.integer :author_id
      t.string :nickname
      t.string :reference_publication
      t.string :reference_title
      t.date :reference_publication_date
      t.string :reference_link
      t.string :reference_author
      t.boolean :editor_verified, default: false

      t.timestamps null: false
    end
  end
end
