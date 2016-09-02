class Renametemplatestokindsaddreference < ActiveRecord::Migration
  def change
    remove_reference :projects, :template
    add_reference :projects, :kind

  end
end
