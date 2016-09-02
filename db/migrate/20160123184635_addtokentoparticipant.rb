class Addtokentoparticipant < ActiveRecord::Migration
  def change
    add_column :participants, :token, :string
  end
end
