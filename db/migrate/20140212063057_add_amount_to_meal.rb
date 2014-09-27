class AddAmountToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :amount, :float
    add_column :meals, :is_paid, :integer
  end
end
