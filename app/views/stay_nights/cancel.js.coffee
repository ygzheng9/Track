<% @stay_night = StayNight.new %>
$("#Night_Form").html("<%= j render 'form' %>")

$("#Night_Form").hide()
$("#Night_Form_new").show()