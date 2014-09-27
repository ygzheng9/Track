$("#<%= dom_id @stay_night %>").remove()
$("#Night_Form_new").show()

<% @stay_night = StayNight.new %>
$("#Night_Form").html("<%= j render 'form' %>")
$("#Night_Form").hide()