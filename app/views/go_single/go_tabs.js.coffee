$("#main").html("<%= j render "single_day_tabs", expense_details: @expense_details, labor_claims: @labor_claims, working_locations: @working_locations, stay_nights: @stay_nights %>")