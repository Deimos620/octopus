class Timescontacted < ActiveRecord::Migration
  def change
    add_column :participants, :times_contacted, :integer, default: 1
  end
end
