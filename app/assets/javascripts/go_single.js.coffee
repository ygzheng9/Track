# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
    $('.subTabs').hide()
    $('.subTabs[id="claim"]').show()

    $('#top_nav li').on 'click', (e) -> 
        $('.subTabs').hide() 

        $('.subTabs[id="' + $(this).attr('id') + '"]').show()
