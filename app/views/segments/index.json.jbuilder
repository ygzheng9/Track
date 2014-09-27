json.array!(@segments) do |segment|
  json.extract! segment, :id, :today, :is_valid, :start, :end, :step, :km, :kcal, :comment
  json.url segment_url(segment, format: :json)
end
