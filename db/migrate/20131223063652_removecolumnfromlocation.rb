class Removecolumnfromlocation < ActiveRecord::Migration
  def change
    remove_column :working_locations, :city_id
  end
end
