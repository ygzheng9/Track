# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->  

  $("#Night_Form").hide()
  $('#Night_Form_new').show()

  $('#Night_Form_new').click ->
    $("#Night_Form").show()
    $(this).hide()