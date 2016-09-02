class CreateBlockedTimes < ActiveRecord::Migration
  def change
    create_table :blocked_times do |t|
      t.references :project_date, index: true
      t.time :time_start
      t.time :time_end
      t.integer :editor_participant_id
      t.timestamps null: false
    end
  end
end
