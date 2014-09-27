$("#<%= dom_id @working_location %>").replaceWith("<%= j render 'working_location', working_location: @working_location %>")
$("#Location_Form_new").show()

<% @working_location = WorkingLocation.new %>
<% @cities = City.all %> 
<% @sites = @cities.first.sites %>
$("#Location_Form").html("<%= j render 'form' %>")
$("#Location_Form_new").hide()