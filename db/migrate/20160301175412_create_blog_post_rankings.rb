class CreateBlogPostRankings < ActiveRecord::Migration
  def change
    create_table :blog_post_rankings do |t|
      t.references :blog_post, index: true
      t.integer :category, default: 1
      t.integer :rank
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end
