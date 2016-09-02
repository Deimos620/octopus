class CreateBlogAuthors < ActiveRecord::Migration
  def change
    create_table :blog_authors do |t|
       t.references :user, index: true
       t.boolean :is_default, default: false
       t.string :first_name
       t.string :last_name
       t.string :avatar
       t.string :twitter
       t.string :slug, index: true
       t.text :bio
       t.integer :editor_user_id, default: 1

      t.timestamps null: false
    end
  end
end
