class CreateProjectDates < ActiveRecord::Migration
  def change
    create_table :project_dates do |t|

      t.references :project, index: true
      t.integer :editor_user_id, default: 1
      t.date :schedule_date, null: false
      t.boolean :available, default: true
      t.boolean :custom_time, default: false
      t.integer :events_count, default: 0

      t.timestamps null: false
    end
  end
end
