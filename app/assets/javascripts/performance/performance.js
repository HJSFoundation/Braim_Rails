//= require highcharts

$(document).ready(function () {
  var chart1;
  var currentTime = (new Date()).getTime();
  Highcharts.setOptions({
      global: {
          useUTC: false
      }
  });

  chart1 = new Highcharts.Chart({
      chart: {
        renderTo: 'container',
        type: 'spline',
        animation: Highcharts.svg, // don't animate in old IE
        marginRight: 10
      },
      title: {
        text: 'Live data'
      },
      xAxis: {
        type: 'datetime',
        tickPixelInterval: 200
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
        enabled: false
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
        pointFormat: '<span style="color:{series.color}">{series.name}: {point.y:.1f}</span><br/>'+ "{point.x}" + '<br/>',
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
      series: [
        {
          name: 'Interest',
          color: 'rgb(255, 0, 255)',
          marker: {
            enabled:false,
            symbol: 'circle'
          },
          data: []
        },
        {
          name: 'Engagement',
          color: '#1eb1b1',
          marker: {
            enabled:false,
            symbol: 'circle'
          },
          data: []
        },
        {
          name: 'Focus',
          color: '#a9d466',
          marker: {
            enabled:false,
            symbol: 'circle'
          },
          data: []
        },
        {
          name: 'Relaxation',
          color: 'rgb(51, 102, 255)',
          marker: {
            enabled:false,
            symbol: 'circle'
          },
          data: []
        },
        {
          name: 'Instantaneous Excitement',
          color: '#ff792b',
          marker: {
            enabled:false,
            symbol: 'circle'
          },
          data: []
        },
        {
          name: 'Long Term Excitement',
          color: 'rgb(153, 204, 255)',
          marker: {
            enabled:false,
            symbol: 'circle'
          },
          data: []
        }
        // ,{
        //   name: 'Stress',
        //   color: 'rgb(255, 255, 0)',
        //   marker: {
        //     enabled:false,
        //     symbol: 'circle'
        //   },
        //   data: []
        // }
        ]
        
    });


  
  $(document).bind("AffectivEmoStateUpdated",function(event,userId,es){
    if (isPerformance){
      var newTime = (new Date()).getTime();
      //console.log(newTime-currentTime);
      if ((newTime-currentTime) > 1000){
        currentTime = newTime;
      
      var interest =Math.round(es.IS_PerformanceMetricGetInterestScore()*1000000)/1000000;
      var engagement = Math.round(es.IS_PerformanceMetricGetEngagementBoredomScore()*1000000)/1000000;
      //var stress = Math.round(es.IS_PerformanceMetricGetStressScore()*1000000)/1000000;
      var focus = Math.round(es.IS_PerformanceMetricGetFocusScore()*1000000)/1000000;
      var relax = Math.round(es.IS_PerformanceMetricGetRelaxationScore()*1000000)/1000000;
      var instantaneousExcitement = Math.round(es.IS_PerformanceMetricGetInstantaneousExcitementScore()*1000000)/1000000;
      var longExcitement = Math.round(es.IS_PerformanceMetricGetExcitementLongTermScore()*1000000)/1000000;
      var series = chart1.series[0],
      shift = series.data.length > 20;
      chart1.series[0].addPoint([currentTime, interest],true,shift);
      chart1.series[1].addPoint([currentTime, engagement],true,shift);
      chart1.series[2].addPoint([currentTime, focus],true,shift);
      chart1.series[3].addPoint([currentTime, relax],true,shift);
      chart1.series[4].addPoint([currentTime, instantaneousExcitement],true,shift);
      chart1.series[5].addPoint([currentTime, longExcitement],true,shift);
      //chart1.series[6].addPoint([currentTime, stress],true,shift);
      }
    }
   
  });

});


