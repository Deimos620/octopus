class CreateSocialAccountAuthorizations < ActiveRecord::Migration
  def change
    create_table :social_account_authorizations do |t|
      t.integer :editor_user_id, default: 1
      t.references :user, index: true
      t.references :social_account, index: true
      t.timestamps null: false
    end
  end
end
