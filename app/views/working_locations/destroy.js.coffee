$("#<%= dom_id @working_location %>").remove()
$("#Location_Form_new").show()

<% @working_location = WorkingLocation.new %>
<% @cities = City.all %> 
<% @sites = @cities.first.sites %>
$("#Location_Form").html("<%= j render 'form' %>")
$("#Location_Form").hide()