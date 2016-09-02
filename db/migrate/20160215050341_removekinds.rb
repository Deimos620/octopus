class Removekinds < ActiveRecord::Migration
  def change
    remove_column :projects, :kind_id, :integer
  end
end
