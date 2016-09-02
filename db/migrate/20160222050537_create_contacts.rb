class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :editor_user_id
      t.integer :importer_user_id, index: true
      t.references :user, index: true
      t.string :prefix
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.string :nickname
      t.string :email
      t.string :url
      t.string :gender
      t.string :birthday
      t.string :primary_phone
      t.string :work_phone
      t.string :home_phone
      t.string :mobile_phone
      t.integer :home_address_id
      t.integer :work_address_id
      t.integer :uploded_id
      t.integer :original_contact_id
      t.integer :status
      t.text :note
      t.timestamps null: false
    end
  end
end
