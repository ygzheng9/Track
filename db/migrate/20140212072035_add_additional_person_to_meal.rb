class AddAdditionalPersonToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :additional_person_id, :integer
  end
end
