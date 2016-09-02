class CreateHonoredGuests < ActiveRecord::Migration
  def change
    create_table :honored_guests do |t|
      t.references :project, index: true
      t.string :name
      t.string :email
      t.references :participant_title, index: true
      t.references :participant, index: true
      t.boolean :passive, default: false
      t.timestamps null: false
    end
  end
end
