json.array!(@working_locations) do |working_location|
  json.extract! working_location, :id, :today, :city_id, :site_id, :Taxi, :comment
  json.url working_location_url(working_location, format: :json)
end
