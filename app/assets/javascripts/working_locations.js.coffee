# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->  

  $("#Location_Form").hide()
  $('#Location_Form_new').show()

  $('#Location_Form_new').click ->
    $("#Location_Form").show()
    $(this).hide()


  $('select#working_location_city_id').change -> 
    selected_id = $(this).val()
    # alert("change! " & selected_id)

    if selected_id is ""
        # if the id is empty remove all the sub_selection options from being selectable
        $site_options = $ "select#working_location_site_id option"
        $site_options.remove

        # insert an empty line to dropdown listbox
        row = "<option value=\"" + "" + "\">" + "Empty Site" + "</option>"
        $site_list = $ "select#working_location_site_id"
        $(row).appendTo $site_list
    else 
        # Send the request and update site dropdown
        $.ajax '/get_sites', 
          dataType: "json"
          cache: false            
          data: {city_id: selected_id}            
          timeout: 2000

          error: (XMLHttpRequest, errorTextStatus, error) ->
            alert "Failed to submit : " + errorTextStatus + " " + error
      
          success: (data) -> 
            $('select#working_location_site_id option').remove()

            $site_list = $ "select#working_location_site_id"

            # put in a empty default line
            row = "<option value=\"" + "" + "\">" + "Please select one site" + "</option>"
            $(row).appendTo $site_list

            # Fill site options
            $.each data, (idx, val) -> 
              row = "<option value=\"" + val.id + "\">" + val.name + "</option>"  
              $(row).appendTo $site_list