class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :editor_participant_id
      t.references :user, index: true
      t.references :project, index: true
      t.string :type #SaveTheDates, #Guests, #Custom, #Engagement, #Announcement
      t.string :custom_name
      t.boolean :has_limit, default: false
      t.integer :limit
      t.integer :status
      t.boolean :rsvp_needed, default: true
      t.boolean :has_meals, default: true
      t.timestamps null: false
    end
  end
end
