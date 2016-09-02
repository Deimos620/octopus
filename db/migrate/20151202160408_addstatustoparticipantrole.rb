class Addstatustoparticipantrole < ActiveRecord::Migration
  def change
    add_column :participant_roles, :status, :int, default: 1
  end
end
