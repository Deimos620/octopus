class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :editor_user_id, default: 1
      t.integer :organizer_participant_id , index: true
      t.integer :status, default: 0
      t.string :type,  null: false, default: ""
      t.string :title
      t.string :short_description
      t.text :long_description
      t.string :img
      t.date :start_date
      t.date :end_date
      t.time :time_start
      t.time :time_end
      t.datetime :prep_start_datetime
      t.datetime :prep_end_datetime
      # t.string :in_honor
      t.integer :form_progress

      t.integer :participants_count
      t.integer :guests_count
      t.integer :items_count
      t.integer :tasks_count
      t.integer :milestones_count
      t.integer :events_count

      t.string :notes
      t.string :max_visits

      t.integer :approver_user_id
      t.boolean :approved, default: false
      t.datetime :approved_at

      t.timestamps null: false
    end
  end
end
