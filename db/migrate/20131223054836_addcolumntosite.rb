class Addcolumntosite < ActiveRecord::Migration
  def change
    add_column :sites, :city_id, :integer
  end
end
