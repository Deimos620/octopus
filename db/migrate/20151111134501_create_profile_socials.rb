class CreateProfileSocials < ActiveRecord::Migration
  def change
    create_table :profile_socials do |t|
      t.references :profile
      t.string :name
      t.string :avatar
      t.string :link

      t.timestamps null: false
    end
  end
end
