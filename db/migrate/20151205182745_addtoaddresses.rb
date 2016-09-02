class Addtoaddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :website, :string
    add_column :addresses, :phone, :string

  end
end
