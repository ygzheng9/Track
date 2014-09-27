json.array!(@labor_claims) do |labor_claim|
  json.extract! labor_claim, :id, :today, :project_id, :hours, :comment
  json.url labor_claim_url(labor_claim, format: :json)
end
