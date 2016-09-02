class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.references :user
      t.integer :platform
      t.string :name
      t.string :url
      t.integer :editor_user_id, default: 1
      t.string :username, index: true
      t.string :access_token
      t.string :access_secret
      t.string :login
      t.string :encrypted_password, null: false, default: ""
      t.boolean :internal, default: false

      t.timestamps null: false
    end
  end
end
