class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :project, index: true
      t.references :participant, index: true
      t.references :project_date, index: true
      t.integer :editor_user_id, default: 1
      t.text :description
      t.string :location
      t.references :address
      t.date :date_start
      t.date :date_end
      t.boolean :all_day
      t.string :repeat
      t.integer :status, default: 1
      t.string :category
      t.time :time_start
      t.time :time_end
      t.integer :attendees_count

      t.timestamps null: false
    end
  end
end

