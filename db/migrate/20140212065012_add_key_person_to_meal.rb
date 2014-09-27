class AddKeyPersonToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :key_person_id, :integer
  end
end
