class CreateSocialShares < ActiveRecord::Migration
  def change
    create_table :social_shares do |t|
       t.integer :editor_user_id, default: 1
       t.references :blog_post, index: true
       t.references :social_account, index: true
       t.text :tweet, limit: 255
       t.text :copy, limit: 500
       t.string :header
       t.string :subheader
       t.string :default_image
       t.string :landscape_image
       t.string :square_image
       t.string :portrait_image
       t.string :scheduled_datetime
       t.string :url
       t.integer :status, default: 1
       t.integer :about_octopus, default: true
       t.string :share_platform_uid
      t.timestamps null: false
    end
  end
end
