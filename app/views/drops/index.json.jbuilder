json.array!(@drops) do |drop|
  json.extract! drop, :id, :today, :getup_at, :sleep_at, :step, :km, :kcal, :pp, :xx, :comment
  json.url drop_url(drop, format: :json)
end
