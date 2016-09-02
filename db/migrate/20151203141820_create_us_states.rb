class CreateUSStates < ActiveRecord::Migration
  def change
    create_table :us_states do |t|
      t.string :name
      t.string :code

      t.timestamps null: false
    end
  end
end
