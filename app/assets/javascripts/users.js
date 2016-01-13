//= require_tree ./plugin
//= require_tree ./page
//= require emotiv_script
//= require user_forms
//= require elasticsearch.jquery.min
load_song_page = function(){
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
  var user_recordings;
  var new_recording_data_id;
  var userID =1;
  var client = new $.es.Client({
    hosts: 'localhost:9200'
  });
  function is_song_path(){
    return window.location.pathname.indexOf("/songs") > -1 && window.location.pathname.indexOf("/songs/search") == -1;
  };
  currentSongID = $("#record_performance_button").data("song-id");
  if(is_song_path()){
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
    load_user_recordings();
  }
  function load_user_recordings(){
    client.search({
      index: 'braim',
      type: 'recording',
      //q: 'user_id:1',
      body: {
        query: {
          bool:{
            "must": [
              { "match": { user_id:   1 }}, 
              { "match": { song_id: currentSongID }}  
            ]
          }
        }
      },
      sort: "date:asc",
      size: 1000
    },function get_recordings(error,response){
      //console.log('total recordings');
      user_recordings = response.hits.hits; 
      new_recording_data_id = userID+currentSongID+user_recordings.length+1;
      console.log('user recordings');
      console.log(user_recordings);
      console.log('new recording id');
      console.log(new_recording_data_id);
      display_recordings(user_recordings);
    });
  }
  function graph_recording(rec_id,date, response){
        var entries = response.hits.hits;
        var interest = [];
        var engagement = [];
        var focus = [];
        var relax = [];
        var instantaneousExcitement = [];
        var longTermExcitement = [];
        var stress = [];
        var rec_date = new Date(date);
        console.log(entries);
        entries.forEach(function(entry,index){
          interest.push([(entry._source.timestamp/1000),entry._source.interest]);
          engagement.push([(entry._source.timestamp/1000),entry._source.engagement]);
          focus.push([(entry._source.timestamp/1000),entry._source.focus]);
          relax.push([(entry._source.timestamp/1000),entry._source.relax]);
          instantaneousExcitement.push([(entry._source.timestamp/1000),entry._source.instantaneousExcitement]);
          longTermExcitement.push([(entry._source.timestamp/1000),entry._source.longTermExcitement]);
          stress.push([(entry._source.timestamp/1000),entry._source.stress]);
        });
        var chart_title = "Recording id: "+rec_id

        new Highcharts.Chart({
          chart: {
            renderTo: rec_id,
            type: 'spline',
            animation: Highcharts.svg, // don't animate in old IE
            marginRight: 10
          },
          title: {
              text: chart_title,
              x: -20 //center
          },
          subtitle: {
              text: chart_title,
              x: -20
          },
          yAxis: {
            title: {
            style:{display:'none'},
            text: 'Value'
          },
          tickInterval: 0.2,
          max: 1,
          min: 0,
          title: false,
          lineWidth: 2
          },
          exporting: {
            enabled: true
          },
          plotOptions: {
            series: {
              states: {
                hover: {
                  enabled: true
                }
              }
            }
          },
          tooltip: {
            enabled: true,
            headerFormat:'',
            pointFormat: '<span style="color:{series.color}">{series.name}: {point.y:.1f}</span><br>',
            style:{
              color:'white',
              fontSize:'12px'
            },
            backgroundColor:'rgba(0, 0, 0, 0.83)',
            crosshairs: true,
            shared: true,
            borderColor: 'rgba(0, 0, 0, 0.83)'
          },
             
        legend: {
            enabled: false
        },
          series: [{
            name: 'Interest',
            color: 'rgb(255, 0, 255)',
            marker: {
              enabled:false,
              symbol: 'circle'
            },
            data: interest
          },
          {
            name: 'Engagement',
            color: '#1eb1b1',
            marker: {
              enabled:false,
              symbol: 'circle'
            },
            data: engagement
          },
          {
            name: 'Focus',
            color: '#a9d466',
            marker: {
              enabled:false,
              symbol: 'circle'
            },
            data: focus
          },
          {
            name: 'Relaxation',
            color: 'rgb(51, 102, 255)',
            marker: {
              enabled:false,
              symbol: 'circle'
            },
            data: relax
          },
          {
            name: 'Instantaneous Excitement',
            color: '#ff792b',
            marker: {
              enabled:false,
              symbol: 'circle'
            },
            data: instantaneousExcitement
          },
          {
            name: 'Long Term Excitement',
            color: 'rgb(153, 204, 255)',
            marker: {
              enabled:false,
              symbol: 'circle'
            },
            data: longTermExcitement
          },{
            name: 'Stress',
            color: 'rgb(255, 255, 0)',
            marker: {
              enabled:false,
              symbol: 'circle'
            },
            data: stress
          }]
      });
  }
  function display_recordings(recordings){
    /*
    recordings.forEach(function(rec,index){
      //TODO Change for scroll
      
    });
  */
    recordings.forEach(function(rec,index){
      $("#song_recordings").append("<h3>"+(new Date(rec._source.date))+"</h3><a class='song-recording' data-recording-id="+rec._id+" data-recording-date="+rec._source.date+">View Graph</a><div id="+rec._id+"></div>");
    });
  }
  function bulk(bulk_request){
    client.bulk({
      body: bulk_request
    }, function (err, resp) {
      console.log('bunlink...');
      console.log(resp);
      console.log(err);
      $("#stop_record_performance_button").toggleClass('disabled');
      $("#record_performance_button").toggleClass('disabled');
      $("#record_message").toggle();
      $(".record-data").toggle();
      clearInterval(interval);
      $("#song_recordings").html("");
      setTimeout(load_user_recordings,1000);
      $("#save_recording_modal").modal('hide');
    });
  }
  $(document).on('click','.song-recording',function(e){
    e.preventDefault();
    $(this).hide();
    var link = $(this);
    var rec_id = link.data('recording-id');
    var rec_date = link.data('recording-date');
    var query = "recording_id:"+rec_id;
      client.search({
        index: 'braim',
        type: 'entry',
        q: query,
        sort: "date:desc",
        size: 1000
      },function get_recordings(error,response){
        //console.log('total entries');
        //console.log(rec._id);
        graph_recording(rec_id,rec_date,response);
        //console.log($("#"+rec._id));
      })
  });
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
    var count = recording.length;
    var bulk_request = []
    for (var i = 0; i < count ; i++){
      bulk_request.push({index: {_index: 'braim', _type: 'entry'}});
      bulk_request.push(recording[i])
    }
    var new_recording_data = {user_id: 1,date: timeStart, song_id: currentSongID}
    console.log(new_recording_data_id);
    bulk_request.push({index: {_index: 'braim', _type: 'recording',_id: new_recording_data_id}});
    bulk_request.push(new_recording_data);
    bulk(bulk_request);
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
    var new_date = (new Date()).getTime();
    var performance_data = {
      user_id: 1,
      recording_id: new_recording_data_id,
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
    recording.push(performance_data);
    show_recording_data(performance_data);
    //console.log(recording);
  }
  $(document).on("click","#record_performance_button",function(e){
    e.preventDefault();
    chart =  Highcharts.charts[0];
    if(chart.series[0].data.length<1){
      alert("connect the device first");
    }else{
    initialize_recording();
    time = 0;
    $(this).toggleClass('disabled');
    $("#stop_record_performance_button").toggleClass('disabled');
    $("#record_message").toggle()
    $(".record-data").toggle()
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
};

$(document).ready(load_song_page);
$(document).on('page:load', load_song_page)