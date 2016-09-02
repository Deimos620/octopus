class Renametemplatestokinds < ActiveRecord::Migration
  def change
    rename_table :templates, :kinds
  end
end
