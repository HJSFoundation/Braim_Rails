$(document).ready ->
  $(document).bind("ajaxSend", ->
    $("#ajax_message").show()
   ).bind "ajaxComplete", ->
    $("#ajax_message").hide()
