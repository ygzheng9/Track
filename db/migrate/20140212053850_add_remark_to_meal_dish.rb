class AddRemarkToMealDish < ActiveRecord::Migration
  def change
    add_column :meal_dishes, :remark, :text
  end
end
