class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :drop_id
      t.time :start
      t.time :end
      t.text :remark
      t.integer :spot_id

      t.timestamps
    end
  end
end
