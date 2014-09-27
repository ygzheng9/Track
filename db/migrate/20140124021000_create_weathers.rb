class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.string :Condition
      t.text :comment

      t.timestamps
    end
  end
end
