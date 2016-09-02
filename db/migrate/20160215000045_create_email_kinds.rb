class CreateEmailKinds < ActiveRecord::Migration
  def change
    create_table :email_kinds do |t|
      t.integer :email_theme_id, index: true
      t.integer :editor_user_id, default: 1
      t.string :type, null: false, default: ""
      t.string :project_type
      t.boolean :admin, default: false
      t.string :role_type
      t.string :category
      t.string :label
      t.string :subject
      t.integer :max_sends
      t.timestamps null: false
    end
  end
end

