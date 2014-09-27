json.array!(@weathers) do |weather|
  json.extract! weather, :id, :name, :comment
  json.url weather_url(weather, format: :json)
end
