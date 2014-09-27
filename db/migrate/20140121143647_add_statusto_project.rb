class AddStatustoProject < ActiveRecord::Migration
  def change
    add_column :projects, :is_availiable, :boolean, default: true
  end  
end
