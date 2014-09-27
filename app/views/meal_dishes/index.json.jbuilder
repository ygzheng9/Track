json.array!(@meal_dishes) do |meal_dish|
  json.extract! meal_dish, :id, :meal_id, :dish_id, :amount, :quantity
  json.url meal_dish_url(meal_dish, format: :json)
end
