$(document).ready ->  

  today = new Date() 
  last_week = new Date()
  last_week.setDate(today.getDate() - 5) 

  
  $( "#src_date_picker" ).datepicker
    dateFormat: "yy-mm-dd"
  
  $( "#fm_dtp" ).datepicker
    defaultDate: "-1w",
    changeMonth: true,
    numberOfMonths: 2,
    maxDate: today, 
    dateFormat: "yy-mm-dd", 
    onClose: ( selectedDate ) -> 
      $( "#to_dtp" ).datepicker( "option", "minDate", selectedDate )

  # $( "#fm_dtp" ).val(last_week.toLocaleDateString())

  $( "#to_dtp" ).datepicker
    defaultDate: null,
    changeMonth: true,
    numberOfMonths: 2,
    dateFormat: "yy-mm-dd", 
    onClose: ( selectedDate ) -> 
      $( "#fm_dtp" ).datepicker( "option", "maxDate", selectedDate )

  # $( "#to_dtp" ).val(today.toLocaleDateString())