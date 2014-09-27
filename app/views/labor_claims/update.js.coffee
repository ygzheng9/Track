$("#<%= dom_id @labor_claim %>").replaceWith("<%= j render 'claim_record', labor_claim: @labor_claim %>")
$('#Claim_Form_new').show()

<% @labor_claim = LaborClaim.new %>
$("#Claim_Form").html("<%= j render 'form' %>")
$("#Claim_Form").hide()
