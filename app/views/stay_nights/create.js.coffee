$('<%=j render 'hotel_night', stay_night: @stay_night %>').appendTo('#Night_List').hide().fadeIn()
$("#Night_Form_new").show()

<% @stay_night = StayNight.new %>
$("#Night_Form").html("<%= j render 'form' %>")
$("#Night_Form").hide()