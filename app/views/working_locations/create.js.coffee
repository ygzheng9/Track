$('<%=j render 'working_location', working_location: @working_location %>').appendTo('#Location_List').hide().fadeIn()
$("#Location_Form_new").show()

<% @working_location = WorkingLocation.new %>
<% @cities = City.all %> 
<% @sites = @cities.first.sites %>
$("#Location_Form").html("<%= j render 'form' %>")
$("#Location_Form").hide()