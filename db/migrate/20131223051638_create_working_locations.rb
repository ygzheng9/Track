class CreateWorkingLocations < ActiveRecord::Migration
  def change
    create_table :working_locations do |t|
      t.date :today
      t.integer :city_id
      t.integer :site_id
      t.float :Taxi
      t.string :comment

      t.timestamps
    end
  end
end
