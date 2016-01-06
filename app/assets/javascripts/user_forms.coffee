
ready = ->

  $(document).on "click", ".audioButton",(event)->
    event.preventDefault()
    button = $(this)
    song = button.prev()[0]
    unless song.paused
      song.pause()
    else
      $(".audio-play").each ->
        this.pause()
        this.currentTime = 0
      song.currentTime = 0
      song.play()

  $(document).bind("ajaxSend", ->
    $("#ajax_message").show()
   ).bind "ajaxComplete", ->
    $("#ajax_message").hide()


$(document).ready(ready)
$(document).on('page:load', ready)