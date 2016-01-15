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
  
  $(document).on "click", ".show-graph-btn",(e)->
    e.preventDefault();
    client = new $.es.Client({
      hosts: 'localhost:9200'
    });
    rec_id =$(this).data("rec-id")
    query = "recording_id:"+rec_id
    $("#graph_modal").modal('show')
    $("#modal-message").show()
    client.search {
      index: 'braim'
      type: 'entry'
      q: query
      sort: 'date:desc'
      size: 1000
    }, (error, response) ->
      graph_modal_recording rec_id, response
      $("#modal-message").hide()
      return

  graph_modal_recording = (rec_id,response)->
    entries = response.hits.hits
    interest = []
    engagement = []
    focus = []
    relax = []
    instantaneousExcitement = []
    longTermExcitement = []
    stress = []
    entries.forEach (entry, index) ->
      interest.push [
        entry._source.timestamp / 1000
        entry._source.interest
      ]
      engagement.push [
        entry._source.timestamp / 1000
        entry._source.engagement
      ]
      focus.push [
        entry._source.timestamp / 1000
        entry._source.focus
      ]
      relax.push [
        entry._source.timestamp / 1000
        entry._source.relax
      ]
      instantaneousExcitement.push [
        entry._source.timestamp / 1000
        entry._source.instantaneousExcitement
      ]
      longTermExcitement.push [
        entry._source.timestamp / 1000
        entry._source.longTermExcitement
      ]
      stress.push [
        entry._source.timestamp / 1000
        entry._source.stress
      ]
      return
    new (Highcharts.Chart)(
      chart:
        renderTo: 'grap_container'
        type: 'spline'
        animation: Highcharts.svg
        marginRight: 10
      title:
        text: 'Recording'
        x: -20
      subtitle:
        text: 'Recording'
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
