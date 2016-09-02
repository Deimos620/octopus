class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      # t.references :list_recipient, index: true
      t.references :contact, index: true
      t.integer :meal_option_id
      t.integer :guest_household_id
      t.text :note
      t.integer :guest_category_id, index: true
      t.timestamps null: false
    end
  end
end
