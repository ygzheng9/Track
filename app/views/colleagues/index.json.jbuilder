json.array!(@colleagues) do |colleague|
  json.extract! colleague, :id, :name, :remark
  json.url colleague_url(colleague, format: :json)
end
