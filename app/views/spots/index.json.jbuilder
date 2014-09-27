json.array!(@spots) do |spot|
  json.extract! spot, :id, :name, :remark
  json.url spot_url(spot, format: :json)
end
