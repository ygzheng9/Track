json.array!(@expense_details) do |expense_detail|
  json.extract! expense_detail, :id, :today, :expense_type_id, :payment_type_id, :amount, :comment
  json.url expense_detail_url(expense_detail, format: :json)
end
