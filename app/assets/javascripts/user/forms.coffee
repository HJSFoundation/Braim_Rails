$(document).ready ->
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
    $("#loading_modal").modal('show')
   ).bind "ajaxComplete", ->
    $("#ajax_message").hide()
    $("#loading_modal").modal('hide')

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
  
  $(document).on "click", ".show-graph-btn",(e)->
    e.preventDefault();
    rec_id =$(this).data("rec-id")
    $("#graph_modal").modal('show')
    $("#modal-message").show()
    $.ajax
      url: '/recordings/show_data'
      type: 'get'
      dataType: 'json'
      success: (data) ->
        console.log "success!"
        graph_data(data,rec_id)
        return
      data: 
        id: rec_id

    graph_data = (data,rec_id)->
      interest = []
      engagement = []
      focus = []
      relax = []
      instantaneousExcitement = []
      longTermExcitement = []
      stress = []
      data.forEach (entry, index) ->
        interest.push [
          entry.timestamp / 1000
          entry.interest
        ]
        engagement.push [
          entry.timestamp / 1000
          entry.engagement
        ]
        focus.push [
          entry.timestamp / 1000
          entry.focus
        ]
        relax.push [
          entry.timestamp / 1000
          entry.relaxation
        ]
        instantaneousExcitement.push [
          entry.timestamp / 1000
          entry.instantaneousExcitement
        ]
        longTermExcitement.push [
          entry.timestamp / 1000
          entry.longTermExcitement
        ]
        stress.push [
          entry.timestamp / 1000
          entry.stress
        ]
        return
      chart_title = "Recording id: "+rec_id

      new (Highcharts.Chart)(
        chart:
          renderTo: 'grap_container'
          type: 'spline'
          animation: Highcharts.svg
          marginRight: 10
        title:
          text: chart_title
          x: -20
        subtitle:
          text: chart_title
          x: -20
        yAxis:
          title:
            style: display: 'none'
            text: 'Value'
          tickInterval: 0.2
          max: 1
          min: 0
          title: false
          lineWidth: 2
        exporting: enabled: true
        plotOptions: series: states: hover: enabled: true
        tooltip:
          enabled: true
          headerFormat: ''
          pointFormat: '<span style="color:{series.color}">{series.name}: {point.y:.1f}</span><br>'
          style:
            color: 'white'
            fontSize: '12px'
          backgroundColor: 'rgba(0, 0, 0, 0.83)'
          crosshairs: true
          shared: true
          borderColor: 'rgba(0, 0, 0, 0.83)'
        legend: enabled: false
        series: [
          {
            name: 'Interest'
            color: 'rgb(255, 0, 255)'
            marker:
              enabled: false
              symbol: 'circle'
            data: interest
          }
          {
            name: 'Engagement'
            color: '#1eb1b1'
            marker:
              enabled: false
              symbol: 'circle'
            data: engagement
          }
          {
            name: 'Focus'
            color: '#a9d466'
            marker:
              enabled: false
              symbol: 'circle'
            data: focus
          }
          {
            name: 'Relaxation'
            color: 'rgb(51, 102, 255)'
            marker:
              enabled: false
              symbol: 'circle'
            data: relax
          }
          {
            name: 'Instantaneous Excitement'
            color: '#ff792b'
            marker:
              enabled: false
              symbol: 'circle'
            data: instantaneousExcitement
          }
          {
            name: 'Long Term Excitement'
            color: 'rgb(153, 204, 255)'
            marker:
              enabled: false
              symbol: 'circle'
            data: longTermExcitement
          }
          {
            name: 'Stress'
            color: 'rgb(255, 255, 0)'
            marker:
              enabled: false
              symbol: 'circle'
            data: stress
          }
        ])
  