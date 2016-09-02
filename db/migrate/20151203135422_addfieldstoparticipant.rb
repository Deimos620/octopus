class Addfieldstoparticipant < ActiveRecord::Migration
  def change
    add_column :participants, :relationship, :string #mother of 
    add_column :participants, :relationship_to_participant_id, :int #participant.id
    add_column :participants, :relationship_to_name, :string #Jessica
    add_column :participants, :relationship_to_title, :string #the Bride
    add_column :participants, :is_star, :boolean, default: false

  end
end
