class CreateEmailLists < ActiveRecord::Migration
  def change
    create_table :email_lists do |t|
      t.integer :editor_user_id, default: 1
      t.references :email_kind
      t.string :user_id
      t.boolean :subscribed, default: true
      t.timestamps null: false
    end
  end
end
