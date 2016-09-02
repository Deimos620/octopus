class Addactsasparanoidcolumn < ActiveRecord::Migration
  def change


    add_column :projects, :deleted_at, :datetime
    add_index :projects, :deleted_at

    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
  end
end
