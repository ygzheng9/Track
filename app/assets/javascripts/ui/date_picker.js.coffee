$(document).ready ->  

  today = new Date()  
  last_week = new Date()
  last_week.setDate(today.getDate() - 7)

  
  $( "#from_date_picker" ).datepicker
    defaultDate: "-1w",
    changeMonth: true,
    numberOfMonths: 3,
    maxDate: today, 
    dateFormat: "yy-mm-dd", 
    onClose: ( selectedDate ) -> 
      $( "#to_date_picker" ).datepicker( "option", "minDate", selectedDate )

  $( "#from_date_picker" ).val(last_week.toLocaleDateString())
  # $( "#from_date_picker" ).val(last_week)

  $( "#to_date_picker" ).datepicker
    defaultDate: null,
    changeMonth: true,
    numberOfMonths: 3,
    dateFormat: "yy-mm-dd", 
    onClose: ( selectedDate ) -> 
      $( "#from_date_picker" ).datepicker( "option", "maxDate", selectedDate )

  $( "#to_date_picker" ).val(today.toLocaleDateString())

  $('#go_single_day').click -> 
    from_date = $('#from_date_picker').val()
    to_date = $('#to_date_picker').val()
    
    if from_date is null or from_date is '' or to_date is null or to_date is ''
      alert "Please select a date..."   
      false
