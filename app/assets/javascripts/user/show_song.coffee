$(document).ready ->
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

  currentSongID = $("record_performance_button").data("song-id")
  userID = $("record_performance_button").data("user-id")

  initialize_recording = ->
    data = []
  
  draw = ->
    time = time+1000
    $("#message_time").html(time/1000)

    if time > currentSongDuration
      console.log 'fin'
      $('#stop_record_performance').click()

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
    data.push(performance_data);
    show_recording_data(performance_data);
  

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
    #console.log(data);
    count = recording.length;
    bulk_request = {
      recording: null,
      data: null
    }
    new_recording_data = {user_id: userID,date: timeStart, song_id: currentSongID, duration: count}
    bulk_request.recording = new_recording_data
    bulk_request.data = data
    console.log bulk_request

  $("#cancel_recording_button").on "click" , ->
    $("#stop_record_performance_button").toggleClass('disabled');
    $("#record_performance_button").toggleClass('disabled');
    $("#record_message").toggle();
    clearInterval(interval);
    $("#save_recording_modal").modal('hide');
  


