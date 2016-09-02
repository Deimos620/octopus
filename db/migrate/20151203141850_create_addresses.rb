class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :editor_user_id
      t.integer :importer_user_id
      t.integer :editor_participant_id
      t.references :us_state, index: true
      t.references :country, index: true
      t.string :owner_type, index: true
      t.integer :owner_id, index: true
      t.integer :kind, default: 1, index: true
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :postal_code
      t.string :venue #
      t.string :title #
      t.boolean :primary, default: true


      t.timestamps null: false
    end
  end
end
