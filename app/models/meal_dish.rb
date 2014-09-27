class MealDish < ActiveRecord::Base

  validates_presence_of :meal_id, :dish_id
  validates_numericality_of :amount, :quantity, greater_than_or_equal_to: 0

  belongs_to :meal
  belongs_to :dish
end
