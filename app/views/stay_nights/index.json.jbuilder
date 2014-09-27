json.array!(@stay_nights) do |stay_night|
  json.extract! stay_night, :id, :today, :city_id, :hotel_id, :rate, :comment
  json.url stay_night_url(stay_night, format: :json)
end
