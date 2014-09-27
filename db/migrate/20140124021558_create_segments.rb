class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.date :today
      t.integer :is_valid
      t.time :start
      t.time :end
      t.integer :step
      t.float :km
      t.float :kcal
      t.text :comment

      t.timestamps
    end
  end
end
