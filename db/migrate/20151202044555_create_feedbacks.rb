class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :user
      t.references :project, index: true
      t.integer :editor_user_id, default: 1
      t.datetime :editor_user_viewed, index: true
      t.boolean :viewed, default: false, index: true
      t.boolean :flagged, default: false, index: true
      t.string :country, default: 'USA'
      t.string :language, default: 'en-us'
      t.integer :category, default: 1
      t.string :page
      t.string :browser
      t.string :version
      t.string :platform
      t.string :os
      t.text :feedback

      

      t.timestamps null: false

    end
  end
end
