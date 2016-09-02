class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :project_type
      t.string :title
      t.integer :kind, default: 1
      t.integer :rank, default: 99
      t.boolean :wedding_related, default: false
      t.boolean :baby_related, default: false
      t.string :short_description
      t.text :long_description
      t.string :icon
      t.integer :status, default: 1
      t.integer :editor_user_id, default: 1
      t.timestamps null: false
    end

    def change
      add_reference :projects, :template
    end
  end
end
