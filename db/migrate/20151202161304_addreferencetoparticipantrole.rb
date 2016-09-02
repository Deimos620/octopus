class Addreferencetoparticipantrole < ActiveRecord::Migration
  def change
    add_reference :participant_roles, :project
    add_reference :projects, :template,  index: true
  end
end
