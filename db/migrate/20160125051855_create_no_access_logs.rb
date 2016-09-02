class CreateNoAccessLogs < ActiveRecord::Migration
  def change
    create_table :no_access_logs do |t|
      t.references :user, index: true
      t.string :previous_page
      t.string :browser
      t.string :version
      t.string :platform
      t.string :os
      t.timestamps null: false
    end
  end
end
