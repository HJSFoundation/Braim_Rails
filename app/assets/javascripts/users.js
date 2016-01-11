//= require_tree ./plugin
//= require_tree ./page
//= require emotiv_script
//= require user_forms
//= require elasticsearch.jquery.min
$(document).ready(function(){
  var interval = null;
  var chart;
  var timeStart;
  var currentSongID;
  var currentSongDuration;
  var emotiv_interest;
  var emotiv_engagement;
  var emotiv_focus;
  var emotiv_relax;
  var emotiv_instantaneousExcitement; 
  var emotiv_longExcitement;
  var emotiv_stress;
  var recording; 
  var time;
  var client = new $.es.Client({
    hosts: 'localhost:9200'
  });
  client.ping({
    requestTimeout: 30000,

    // undocumented params are appended to the query string
    hello: "elasticsearch"
  }, function (error) {
    if (error) {
      console.error('elasticsearch cluster is down!');
    } else {
      console.log('All is well');
    }
  });
  function bulk(response){
    client.bulk({
      body: [
        // action description
        { index:  { _index: 'myindex', _type: 'mytype', _id: 1 } },
         // the document to index
        { title: 'foo' },
        // action description
        { update: { _index: 'myindex', _type: 'mytype', _id: 2 } },
        // the document to update
        { doc: { title: 'foo' } },
        // action description
        { delete: { _index: 'myindex', _type: 'mytype', _id: 3 } },
        // no document needed for this delete
      ]
    }, function (err, resp) {
      console.log('bunlink...');
      console.log(resp);
      console.log(err);
    });
  }
  function initialize_recording(){
    recording = []
  }
  function show_recording_data(performance_data){
    $(".interest span").html(performance_data.interest);
    $(".engagement span").html(performance_data.engagement);
    $(".focus span").html(performance_data.focus);
    $(".relaxation span").html(performance_data.relaxation);
    $(".inst-excitement span").html(performance_data.instantaneousExcitement);
    $(".long-excitement span").html(performance_data.longTermExcitement);
    $(".stress span").html(performance_data.stress);
  }
  $(document).on('click',"#save_recording_button", function(e){

    e.preventDefault();
    console.log('saving recording...');
    console.log(recording);
  });
  $(document).on('click',"#cancel_recording_button", function(){
    $("#stop_record_performance_button").toggleClass('disabled');
    $("#record_performance_button").toggleClass('disabled');
    $("#record_message").toggle();
    $(".record-data").toggle();
    clearInterval(interval);
    $("#save_recording_modal").modal('hide');
  });
  function draw(){
    time = time+1000;
    //console.log(time);
    $("#message_time").html(time/1000);
    if(time>currentSongDuration){
      console.log("fin");
      $("#stop_record_performance").click();
    }

    emotiv_interest = chart.series[0].data[chart.series[0].data.length-1].y;
    emotiv_engagement = chart.series[1].data[chart.series[1].data.length-1].y;
    emotiv_focus = chart.series[2].data[chart.series[2].data.length-1].y; 
    emotiv_relax = chart.series[3].data[chart.series[3].data.length-1].y;
    emotiv_instantaneousExcitement = chart.series[4].data[chart.series[4].data.length-1].y;
    emotiv_longExcitement = chart.series[5].data[chart.series[5].data.length-1].y;
    emotiv_stress = chart.series[6].data[chart.series[6].data.length-1].y;

    var performance_data = {
      user: 1,
      song_id: currentSongID,
      interest: emotiv_interest,
      engagement: emotiv_engagement,
      focus: emotiv_focus,
      relaxation: emotiv_relax,
      instantaneousExcitement: emotiv_instantaneousExcitement,
      longTermExcitement: emotiv_longExcitement,
      stress: emotiv_stress,
      timestamp: time 
    }
    recording.push(performance_data);
    show_recording_data(performance_data);
    //console.log(recording);
  }
  $("#record_performance_button").on("click",function(e){
    e.preventDefault();
    chart =  $("#container").highcharts();
    if(chart.series[0].data.length<1){
      alert("connect the device first");
    }else{
    initialize_recording();
    time = 0;
    $(this).toggleClass('disabled');
    $("#stop_record_performance_button").toggleClass('disabled');
    $("#record_message").toggle()
    $(".record-data").toggle()
    currentSongID = $(this).data("song-id");
    currentSongDuration = $(this).data("song-duration");
    timeStart = (new Date()).getTime();
    console.log("start recording on: "+timeStart+" current song: "+currentSongID+ "song duration: "+currentSongDuration);
    interval = setInterval(draw,1000);
    }
  });
  $("#stop_record_performance_button").on("click",function(e){
    e.preventDefault();
    $("#save_recording_modal").modal('show');
  });

  $(document).on("page:load",function(){
    if(interval!=null){
      clearInterval(interval);
    }
  });
});