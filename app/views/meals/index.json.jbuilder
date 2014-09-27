json.array!(@meals) do |meal|
  json.extract! meal, :id, :drop_id, :start, :end, :remark, :spot_id
  json.url meal_url(meal, format: :json)
end
