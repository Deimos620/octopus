class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :user, index: true,  null: false, default: ""
      t.integer :editor_user_id, default: 1
      t.string :type,  null: false, default: ""
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
