class CreateContactHouseholds < ActiveRecord::Migration
  def change
    create_table :contact_households do |t|
      t.references :contact, index: true
      t.references :household, index: true
      t.integer :status
      t.timestamps null: false
    end
  end
end
