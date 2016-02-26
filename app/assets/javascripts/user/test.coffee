$(window).load ->
  if window.location.pathname == "/braim_test"
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
    nextTimeCounter = 5

    currentSongID = $("#song-info").data("song-id")
    userID = $("#song-info").data("user-id")

    play_song = ->
      song = $('.audio-test')[0]
      time = song.currentTime % 60
      duration = $('.song-time')
      duration.text("0.0")
      song.play()
      song.addEventListener("timeupdate", ->     
        s = parseInt(song.currentTime % 60);    
        m = parseInt((song.currentTime / 60) % 60);
        duration.text(m + '.' + s)       
      , false);

    initialize_recording = ->
      data = []
    
    draw = ->
      time = time+1000
      $("#message_time").html(time/1000)
      currentSignalQuality  =  parseInt($("#signalQuality").text())
      if time > currentSongDuration
        console.log 'fin'
        save_recording()

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
        date: new_date,
        signal_quality: currentSignalQuality
      }
      #console.log performance_data
      data.push(performance_data);

    start_recording = ->
      chart =  Highcharts.charts[0]
      if chart.series[0].data.length < 1
        alert("the device isnt connected, please reload the page");
      else
        play_song()
        initialize_recording()
        time = 0
        $(this).toggleClass('disabled')
        $("#record_message").toggle()
        currentSongDuration = 30000
        timeStart = (new Date()).getTime()
        console.log("start recording on: "+timeStart+" current song: "+currentSongID+ "song duration: "+currentSongDuration)
        interval = setInterval(draw,1000)
      
    playNextSong = ->
      nextTimeCounter = nextTimeCounter-1
      $("#nextSongCounter").text(" ("+ nextTimeCounter+") ")
      if nextTimeCounter == 0
        window.location.href = "braim_test"

    save_recording = ->
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
          $("#record_message").toggle();
          $("#testModal").modal('show')
          #$("#save_recording_modal").modal('hide');
          setInterval(playNextSong,1000);
          return
        contentType: 'application/json',
        data: JSON.stringify({
          data: bulk_request.data,
          recording: bulk_request.recording
        })

    setTimeout(->
      start_recording()
    ,3000)

  $("#btnTestAgain").on "click", (e)->
    window.location.href = "braim_test?id=#{currentSongID}";
  $("#btnTestNext").on "click", (e)->
    window.location.href = "braim_test";
    


