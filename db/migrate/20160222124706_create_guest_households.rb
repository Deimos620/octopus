class CreateGuestHouseholds < ActiveRecord::Migration
  def change
    create_table :guest_households do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
