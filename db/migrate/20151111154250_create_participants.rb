class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.integer :invitor_user_id, default: 1
      t.integer :editor_user_id, default: 1
      t.string :email, index: true
      t.integer :status, default: 1
      t.text :message
      t.string :title #ie Mother of the Bride
      t.string :conntection_name
      t.string :connected_to
      t.integer :connected_to_user_id
      t.timestamps null: false
    end
  end
end
