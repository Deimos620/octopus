class Renameinvitoruserid < ActiveRecord::Migration
  def change
        rename_column :participants, :invitor_user_id,  :invitor_participant_id
        rename_column :participant_roles, :grantor_user_id,  :grantor_participant_id

  end
end
