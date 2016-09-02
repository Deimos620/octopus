class CreateParticipantTitles < ActiveRecord::Migration
  def change
    create_table :participant_titles do |t|
      t.references :participant, index: true
      t.string :title
      t.string :description
      t.integer :editor_user_id, default: 1
      t.timestamps null: false
    end
  end
end
