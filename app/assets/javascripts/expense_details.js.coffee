# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->  

  $("#Expense_Detail_Form").hide()
  $('#Expense_Detail_Form_new').show()

  $('#Expense_Detail_Form_new').click ->
    $("#Expense_Detail_Form").show()
    $(this).hide()

  $( "#expense_detail_today" ).datepicker
    dateFormat: "yy-mm-dd"