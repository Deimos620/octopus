class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :editor_user_id, default: 1
      t.integer :section_id, index: true
      t.string :slug, index: true
      t.string :title
      t.string :lead
      t.text :body
      t.timestamps null: false
    end
  end
end
