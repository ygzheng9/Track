$('#Claim_Form_new').show()

<% @labor_claim = LaborClaim.new %>
$("#Claim_Form").html("<%= j render 'form' %>")
$("#Claim_Form").hide()
