class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true,  null: false, default: ""
      t.integer :editor_user_id, default: 1
      t.date :birth_date
      t.string :vendor_name
      t.boolean :is_vendor, default: false
      t.string :country, default: 'USA'
      t.string :language, default: 'en-us'

      t.string :phone
      t.string :website
      t.string :referral_code
      t.string :created_at_ip
      t.datetime :originally_created_at

      t.string :time_zone, default: 'Centra Time (US & Canada)'

      t.timestamps null: false
    end
  end
end
