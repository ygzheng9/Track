class CreateStayNights < ActiveRecord::Migration
  def change
    create_table :stay_nights do |t|
      t.date :today
      t.integer :city_id
      t.integer :hotel_id
      t.float :rate
      t.string :comment

      t.timestamps
    end
  end
end
