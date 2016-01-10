//= require_tree ./plugin
//= require_tree ./page
//= require emotiv_script
//= require user_forms
$(document).ready(function(){
  var interval = null;
  var chart;
  var timeStart;
  var currentSongID;
  var currentSongDuration;
  var interest;
  var engagement;
  var focus;
  var relax;
  var instantaneousExcitement; 
  var longExcitement;
  var stress;
  var recording; 
  var time;
  function initialize_recording(){
    recording = {
      user: 1,
      song_id: null,
      data: []
    }
  }
  function show_recording_dara(performance_data){
    $(".interest span").html(performance_data.emotiv_interest);
    $(".engagement span").html(performance_data.emotiv_engagement);
    $(".focus span").html(performance_data.emotiv_focus);
    $(".relaxation span").html(performance_data.emotiv_relax);
    $(".inst-excitement span").html(performance_data.emotiv_instantaneousExcitement);
    $(".long-excitement span").html(performance_data.emotiv_longExcitement);
    $(".stress span").html(performance_data.emotiv_stress);
  }
  function draw(){
    time = time+1000;
    console.log(time);
    $("#message_time").html(time/1000);
    if(time>currentSongDuration){
      console.log("fin");
      $("#stop_record_performance").click();
    }
    show_recording_dara(performance_data);
    interest = chart.series[0].data[chart.series[0].data.length-1].y;
    engagement = chart.series[1].data[chart.series[1].data.length-1].y;
    focus = chart.series[2].data[chart.series[2].data.length-1].y; 
    relax = chart.series[3].data[chart.series[3].data.length-1].y;
    instantaneousExcitement = chart.series[4].data[chart.series[4].data.length-1].y;
    longExcitement = chart.series[5].data[chart.series[5].data.length-1].y;
    stress = chart.series[6].data[chart.series[6].data.length-1].y;
    var performance_data = {
      emotiv_interest: interest,
      emotiv_engagement: engagement,
      emotiv_focus: focus,
      emotiv_relax: relax,
      emotiv_instantaneousExcitement: instantaneousExcitement,
      emotiv_longExcitement: longExcitement,
      emotiv_stress: stress,
      timestamp: time 
    }
    recording.data.push(performance_data);
    //console.log(recording);
  }
  $("#record_performance").on("click",function(e){
    e.preventDefault();
    initialize_recording();
    time = 0;
    $(this).toggleClass('disabled');
    $("#stop_record_performance").toggleClass('disabled');
    $("#record_message").toggle()
    $(".record-data").toggle()
    chart =  $("#container").highcharts();
    currentSongID = $(this).data("song-id");
    currentSongDuration = $(this).data("song-duration");
    recording.song_id = currentSongID;
    timeStart = (new Date()).getTime();
    console.log("start recording on: "+timeStart+" current song: "+currentSongID+ "song duration: "+currentSongDuration);
    interval = setInterval(draw,1000);
  });
  $("#stop_record_performance").on("click",function(e){
    e.preventDefault();
    $(this).toggleClass('disabled');
    $("#record_performance").toggleClass('disabled');
    $("#record_message").toggle()
    $(".record-data").toggle()
    clearInterval(interval);
  });

  $(document).on("page:load",function(){
    if(interval!=null){
      clearInterval(interval);
    }
  });
});