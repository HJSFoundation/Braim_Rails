$(document).ready ->
  currentPage = 1;
  interval = null
  chart = null
  timeStart= null
  currentSongID= null
  currentSongDuration= null
  emotiv_interest= null
  emotiv_engagement= null
  emotiv_focus= null
  emotiv_relax= null
  emotiv_instantaneousExcitement= null
  emotiv_longExcitement= null
  emotiv_stress= null
  data = []
  time= null
  user_recordings= null
  new_recording_data_id= null
  userID= null

  currentSongID = $("#record_performance_button").data("song-id")
  userID = $("#record_performance_button").data("user-id")

  initialize_recording = ->
    data = []
  
  draw = ->
    time = time+1000
    $("#message_time").html(time/1000)

    if time > currentSongDuration
      console.log 'fin'
      $("#save_recording_button").click()

    emotiv_interest = chart.series[0].data[chart.series[0].data.length-1].y;
    emotiv_engagement = chart.series[1].data[chart.series[1].data.length-1].y;
    emotiv_focus = chart.series[2].data[chart.series[2].data.length-1].y; 
    emotiv_relax = chart.series[3].data[chart.series[3].data.length-1].y;
    emotiv_instantaneousExcitement = chart.series[4].data[chart.series[4].data.length-1].y;
    emotiv_longExcitement = chart.series[5].data[chart.series[5].data.length-1].y;
    emotiv_stress = chart.series[6].data[chart.series[6].data.length-1].y;
    new_date = (new Date()).getTime();
    performance_data = {
      user_id: userID,
      song_id: currentSongID,
      interest: emotiv_interest,
      engagement: emotiv_engagement,
      focus: emotiv_focus,
      relaxation: emotiv_relax,
      instantaneousExcitement: emotiv_instantaneousExcitement,
      longTermExcitement: emotiv_longExcitement,
      stress: emotiv_stress,
      timestamp: time,
      date: new_date
    }
    #console.log performance_data
    data.push(performance_data);

  $("#record_performance_button").on "click", (e)->
    e.preventDefault()
    chart =  Highcharts.charts[0]
    if chart.series[0].data.length < 1
      alert("connect the device first");
    else
      initialize_recording()
      time = 0
      $(this).toggleClass('disabled')
      $("#stop_record_performance_button").toggleClass('disabled')
      $("#record_message").toggle()
      currentSongDuration = $(this).data("song-duration")
      timeStart = (new Date()).getTime()
      console.log("start recording on: "+timeStart+" current song: "+currentSongID+ "song duration: "+currentSongDuration)
      interval = setInterval(draw,1000)
    

  $("#stop_record_performance_button").on "click" ,(e)->
    e.preventDefault()
    $("#save_recording_modal").modal('show')


   $("#save_recording_button").on "click", (e)->
    e.preventDefault();
    console.log('saving recording...');
    clearInterval(interval);
    #console.log(data);
    count = data.length;
    bulk_request = {
      recording: null,
      data: null
    }
    new_recording_data = {user_id: userID,date: timeStart, song_id: currentSongID, duration: count}
    bulk_request.recording = new_recording_data
    bulk_request.data = data
    console.log bulk_request
    $.ajax
      url: '/recordings/create'
      type: 'post'
      dataType: 'json'
      success: (data) ->
        console.log "success!"
        console.log data.length
        $("#stop_record_performance_button").toggleClass('disabled');
        $("#record_performance_button").toggleClass('disabled');
        $("#record_message").toggle();
        $("#save_recording_modal").modal('hide');
        redraw_song_recordings()
        return
      contentType: 'application/json',
      data: JSON.stringify({
        data: bulk_request.data,
        recording: bulk_request.recording
      })

  $("#cancel_recording_button").on "click" , ->
    $("#stop_record_performance_button").toggleClass('disabled');
    $("#record_performance_button").toggleClass('disabled');
    $("#record_message").toggle();
    clearInterval(interval);
    $("#save_recording_modal").modal('hide');
  
  $(document).on "click", ".graph-data-link",(e)->
    e.preventDefault()
    recording_id = $(this).data('recording-id')
    $(this).hide()
    $.ajax
      url: '/recordings/show_data'
      type: 'get'
      dataType: 'json'
      success: (data) ->
        console.log "success!"
        graph_data(data,recording_id)
        return
      data: 
        id: recording_id

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
          renderTo: rec_id
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
  
  $("#older_song_recordings").on "click", (e)->
    e.preventDefault()
    currentPage++
    $.ajax
      url: '/recordings/index'
      type: 'get'
      dataType: 'json'
      success: (data) ->
        data.forEach (rec) ->
          title_date = moment(rec.date).format('MMMM DD YYYY, h:mm:ss a')
          $("#song_recordings").append("<h3>Recording "+title_date+"</h3><div id="+rec.id+"></div><a href='#' data-recording-id="+rec.id+" class='graph-data-link'>View Graph</a>")
        return
      data: 
        page: currentPage
        per_page: 5
        user_id: userID
        song_id: currentSongID

  redraw_song_recordings = ->
    currentPage = 1
    $.ajax
      url: '/recordings/index'
      type: 'get'
      dataType: 'json'
      success: (data) ->
        $("#song_recordings").html("")
        data.forEach (rec) ->
          title_date = moment(rec.date).format('MMMM DD YYYY, h:mm:ss a')
          $("#song_recordings").append("<h3>Recording "+title_date+"</h3><div id="+rec.id+"></div><a href='#' data-recording-id="+rec.id+" class='graph-data-link'>View Graph</a>")
        return
      data: 
        page: currentPage
        per_page: 5
        user_id: userID
        song_id: currentSongID



