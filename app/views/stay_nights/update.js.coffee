$("#<%= dom_id @stay_night %>").replaceWith("<%= j render 'hotel_night', stay_night: @stay_night %>")

<% @stay_night = StayNight.new %>
$("#Night_Form").html("<%= j render 'form' %>")

$("#Night_Form").hide()
$("#Night_Form_new").show()