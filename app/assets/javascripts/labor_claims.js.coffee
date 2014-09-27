# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->  

  $("#Claim_Form").hide()
  $('#Claim_Form_new').show()

  $('#Claim_Form_new').click ->
    $("#Claim_Form").show()
    $(this).hide()
  
  $('#Claim_Go').click -> 
    hours = $('#labor_claim_hours').val()
    # alert hours
    
    if hours is null or hours <= 1
      alert "Please input hours..."   
      false