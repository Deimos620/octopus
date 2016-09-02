class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.references :participant, index: true
      t.references :event, index: true
      t.integer :status, default: 1
      t.integer :invitor_participant_id
      t.timestamps null: false
    end
  end
end
