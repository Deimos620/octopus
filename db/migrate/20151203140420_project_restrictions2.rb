class ProjectRestrictions2 < ActiveRecord::Migration
  def change
    create_table :project_restrictions do |t|
      t.references :project,  index: true
      t.references :restriction,  index: true
      t.integer :editor_participant_id
      t.timestamps null: false
    end
  end

end
