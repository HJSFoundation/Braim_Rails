$(document).ready ->
  console.log "Success"
  $("#search_songs").on("ajax:success", (e,data,status,xhr)->
      console.log "Success"
    ).on "ajax:error", (e, xhr,status,error)->
      console.log "Error"