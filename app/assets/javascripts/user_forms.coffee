
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

  $(document).on "click", ".loading-link",(event)->
    $("#ajax_message").show()
  $(document).on "click", ".loading-button",(event)->
    #event.preventDefault()
    $(".bg_load").fadeIn("slow");
    $(".wrapper").fadeIn("slow");
    icon = $(this).find('i')
    message = $(this).find('span')
    icon.addClass("fa fa-circle-o-notch fa-spin")
    message.html("Loading...")
  $(document).on 'submit',"#search_songs_form", ->
    search_button = $(this).find('.search-button')
    icon = search_button.find('i')
    message = search_button.find('span')
    icon.addClass("fa fa-circle-o-notch fa-spin")
    message.html("Loading...")
$(document).ready(ready)
$(document).on('page:load', ready)