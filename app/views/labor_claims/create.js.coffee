$('<%=j render 'claim_record', labor_claim: @labor_claim %>').appendTo('#Claim_List').hide().fadeIn()
$('#Claim_Form_new').show()

<% @labor_claim = LaborClaim.new %>
$("#Claim_Form").html("<%= j render 'form' %>")
$("#Claim_Form").hide()
