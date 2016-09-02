class CreateEmailLogs < ActiveRecord::Migration
  def change
    create_table :email_logs do |t|
        t.integer :sender_user_id, default: 1, index: true
        t.integer :email_kind_id, default: nil, index: true
        t.integer :receiver_participant_id
      t.timestamps null: false
    end
  end
end


