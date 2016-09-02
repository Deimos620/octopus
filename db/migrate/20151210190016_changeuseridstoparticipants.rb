class Changeuseridstoparticipants < ActiveRecord::Migration
  def change
    rename_column :events, :editor_user_id,  :editor_participant_id
    rename_column :kinds, :editor_user_id,  :editor_participant_id
    rename_column :participant_roles, :editor_user_id,  :editor_participant_id
    rename_column :participant_titles, :editor_user_id,  :editor_participant_id
    rename_column :participants, :editor_user_id,  :editor_participant_id
    rename_column :project_dates, :editor_user_id,  :editor_participant_id
    rename_column :projects, :editor_user_id,  :editor_participant_id

  end
end
