class CreateParticipantRole2s < ActiveRecord::Migration
  def change
    create_table :participant_roles do |t|
      t.references :participant, index: true
      t.integer :grantor_user_id, index: true
      t.integer :editor_user_id, default: 1
      t.string :type,  null: false, default: ""
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end


