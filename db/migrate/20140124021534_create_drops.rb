class CreateDrops < ActiveRecord::Migration
  def change
    create_table :drops do |t|
      t.date :today
      t.time :getup_at
      t.time :sleep_at
      t.integer :step
      t.float :km
      t.float :kcal
      t.integer :pp
      t.integer :xx
      t.text :comment

      t.timestamps
    end
  end
end
