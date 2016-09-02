class CreateListRecipients < ActiveRecord::Migration
  def change
    create_table :list_recipients do |t|
      t.integer :guest_id, index: true
      t.integer :editor_participant_id
      t.integer :grantor_participant_id
      t.references :list, index: true
      t.references :household, index: true
      t.string :status
      # t.date :addressed_date
      # t.date :send_date

      t.timestamps null: false
    end
  end
end
