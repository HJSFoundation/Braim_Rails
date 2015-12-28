var timePerformancePeriod = 0;
var timePerformanceChange;
var timePerformanceNow = 0;
var chart1;
var chart2;
var isRenderHighcharts = true;
var periodTime;
var isDrawPerformance = true;
var isStartBaseline = false;
/* } */

  $(document).ready(function(){
          Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
    
        chart1 = new Highcharts.Chart({
            chart: {
        width: 1215,
        style:{color:'white'},
        backgroundColor:'#afafb3',
        plotBackgroundColor: '#676164',
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
        renderTo: 'chart1'
            },
            title: {
                text: 'Live random data',
        color:'white'
            },
            xAxis: {
        style:{display:'none'},
                maxPadding: 0.05,
                showLastLabel: true,
        max: 30,
        min: 0,
        tickInterval: 5
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
        pointFormat: '<span style="color:{series.color}">{series.name}: {point.y:.1f}</span><br/>',
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
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Interest',
         color: 'rgb(255, 0, 255)',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
                data: [[0,0]]
            },
      {
                name: 'Engagement',
         color: '#1eb1b1',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
                data: [[0,0]]
            },
      {
                name: 'Focus',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: '#a9d466',
                data: [[0,0]]
            },
      {
                name: 'Relaxation',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: 'rgb(51, 102, 255)',
                data: [[0,0]]
            },
      {
                name: 'Instantaneous Excitement',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: '#ff792b',
                data: [[0,0]]
            },
      {
                name: 'Long Term Excitement',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: 'rgb(153, 204, 255)',
                data: [[0,0]]
            }]
        });
    chart2 = new Highcharts.Chart({
      
            chart: {
        width: 1215,
        style:{color:'white'},
        backgroundColor:'#afafb3',
        plotBackgroundColor: '#676164',
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
        renderTo: 'chart2'
            },
            title: {
                text: 'Live random data',
        color:'white'
            },
            xAxis: {
        style:{display:'none'},
                maxPadding: 0.05,
                showLastLabel: true,
        max: 300,
        min: 0,
        tickInterval: 50
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
        pointFormat: '<span style="color:{series.color}">{series.name}: {point.y:.1f}</span><br/>',
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
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Interest',
         color: 'rgb(255, 0, 255)',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        data: [[0,0]]
            },
      {
                name: 'Engagement',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: '#1eb1b1',
                data: [[0,0]]
            },
      {
                name: 'Focus',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: '#a9d466',
                data: [[0,0]]
            },
      {
                name: 'Relaxation',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: 'rgb(51, 102, 255)',
                data: [[0,0]]
            },
      {
                name: 'Instantaneous Excitement',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: '#ff792b',
                data: [[0,0]]
            },
      {
                name: 'Long Term Excitement',
         marker: {
          enabled:false,
                    symbol: 'circle'
                },
        color: 'rgb(153, 204, 255)',
                data: [[0,0]]
            }]
        });
    
    //Set size for high chart
    var widthOfWindow = $(window).width();
    if(widthOfWindow>900){
    chart1.setSize(widthOfWindow-150, 350 , true);
    chart2.setSize(widthOfWindow-150, 350 , true);
    }
    else if(widthOfWindow <= 900 && widthOfWindow>500){
    chart1.setSize(widthOfWindow-120, 350 , true);
    chart2.setSize(widthOfWindow-120, 350 , true);
    }
    else{
      chart1.setSize(widthOfWindow-100, 350 , true);
      chart2.setSize(widthOfWindow-100, 350 , true);
    }
    $(window).resize(function()
    {
      var widthOfWindow = $(window).width();
      if(widthOfWindow>900){
        chart1.setSize(widthOfWindow-150, 350 , true);
        chart2.setSize(widthOfWindow-150, 350 , true);
      }
      else if(widthOfWindow <= 900 && widthOfWindow>500){
        chart1.setSize(widthOfWindow-120, 350 , true);
        chart2.setSize(widthOfWindow-120, 350 , true);
      }
      else{
        chart1.setSize(widthOfWindow-100, 350 , true);
        chart2.setSize(widthOfWindow-100, 350 , true);
      }
    });
  
  $(document).bind("AffectivEmoStateUpdated",function(event,userId,es){
    if (isPerformance==true)
    {
      if(!(isDrawPerformance))
      {
        chart1.series[0].setData([]);
        chart1.series[1].setData([]);
        chart1.series[2].setData([]);
        chart1.series[3].setData([]);
        chart1.series[4].setData([]);
        chart1.series[5].setData([]);
        chart2.series[0].setData([]);
        chart2.series[1].setData([]);
        chart2.series[2].setData([]);
        chart2.series[3].setData([]);
        chart2.series[4].setData([]);
        chart2.series[5].setData([]);
        timePerformanceChange = new Date();
        isDrawPerformance = true;
      }
      else
      {
        timePerformanceNow = new Date();
        if(isStartBaseline&&isRenderHighcharts)
        {
          var options = chart1.options;
          options.tooltip.enabled = false;
          options.plotOptions.series.states.hover.enabled = false;
          chart1 = new Highcharts.Chart(options);
          var options = chart2.options;
          options.tooltip.enabled = false;
          options.plotOptions.series.states.hover.enabled = false;
          chart2 = new Highcharts.Chart(options);
          isRenderHighcharts = false;
          var widthOfWindow = $(window).width();
          if(widthOfWindow>900){
            chart1.setSize(widthOfWindow-150, 350 , true);
            chart2.setSize(widthOfWindow-150, 350 , true);
          }
          else if(widthOfWindow <= 900 && widthOfWindow>500){
            chart1.setSize(widthOfWindow-120, 350 , true);
            chart2.setSize(widthOfWindow-120, 350 , true);
          }
          else{
            chart1.setSize(widthOfWindow-100, 350 , true);
            chart2.setSize(widthOfWindow-100, 350 , true);
          }
        }
        if(!isStartBaseline&&!isRenderHighcharts)
        {
          var options = chart1.options;
          options.tooltip.enabled = true;
          options.plotOptions.series.states.hover.enabled = true;
          chart1 = new Highcharts.Chart(options);
          var options = chart2.options;
          options.tooltip.enabled = true;
          options.plotOptions.series.states.hover.enabled = true;
          chart2 = new Highcharts.Chart(options);
          isRenderHighcharts = true;
          var widthOfWindow = $(window).width();
          if(widthOfWindow>900){
            chart1.setSize(widthOfWindow-150, 350 , true);
            chart2.setSize(widthOfWindow-150, 350 , true);
          }
          else if(widthOfWindow <= 900 && widthOfWindow>500){
            chart1.setSize(widthOfWindow-120, 350 , true);
            chart2.setSize(widthOfWindow-120, 350 , true);
          }
          else{
            chart1.setSize(widthOfWindow-100, 350 , true);
            chart2.setSize(widthOfWindow-100, 350 , true);
          }
        }
        if(((timePerformanceNow-timePerformancePeriod>500)&&isStartBaseline==false)||((timePerformanceNow-timePerformancePeriod>3000)&&isStartBaseline==true))
        {
          timePerformancePeriod = new Date();
          periodTime = (timePerformanceNow - timePerformanceChange)/1000;
          //if (timeNow.getTime())
          var interest =Math.round(es.IS_PerformanceMetricGetInterestScore()*1000000)/1000000;
          var engagement = Math.round(es.IS_PerformanceMetricGetEngagementBoredomScore()*1000000)/1000000;
          //var stress = Math.round(EdkDll.ES_AffectivGetFrustrationScore()*1000000)/1000000;
          var focus = Math.round(ELSPlugin().ELS_IS_PerformanceMetricGetFocusScore()*1000000)/1000000;
          var relax = Math.round(es.IS_PerformanceMetricGetRelaxationScore()*1000000)/1000000;
          var instantaneousExcitement = Math.round(es.IS_PerformanceMetricGetInstantaneousExcitementScore()*1000000)/1000000;
          var longExcitement = Math.round(es.IS_PerformanceMetricGetExcitementLongTermScore()*1000000)/1000000;
          var valueShortTime = document.getElementById("display-length-input-1").value;
          var valueLongTime = document.getElementById("display-length-input-2").value;
          
          if (periodTime > valueShortTime)
          {
            chart1.xAxis[0].update({min: (periodTime - valueShortTime), max: periodTime});
          }
          else
          {
            //chart1.xAxis[0].update({min: 0, max: 30});
          }
          if (periodTime > valueLongTime)
          {
            chart2.xAxis[0].update({min: (periodTime - valueLongTime), max: periodTime});
          }
          else
          {
            //chart2.xAxis[0].update({min: 0, max: 300});
          }
          chart1.series[0].addPoint([periodTime, interest]);
          chart1.series[1].addPoint([periodTime, engagement]);
          chart1.series[2].addPoint([periodTime, focus]);
          chart1.series[3].addPoint([periodTime, relax]);
          chart1.series[4].addPoint([periodTime, instantaneousExcitement]);
          chart1.series[5].addPoint([periodTime, longExcitement]);
          
          chart2.series[0].addPoint([periodTime, interest]);
          chart2.series[1].addPoint([periodTime, engagement]);
          chart2.series[2].addPoint([periodTime, focus]);
          chart2.series[3].addPoint([periodTime, relax]);
          chart2.series[4].addPoint([periodTime, instantaneousExcitement]);
          chart2.series[5].addPoint([periodTime, longExcitement]);
        }
      }
    }
  }); 
});

function changeShortPerformance()
{
  var valueShortTime = document.getElementById("display-length-input-1").value;
  if (periodTime > valueShortTime)
  {
    chart1.xAxis[0].update({min: (periodTime - valueShortTime), max: periodTime, tickInterval:Math.round(valueShortTime/6)});
  }
  else
  {
    chart1.xAxis[0].update({min: 0, max: valueShortTime, tickInterval:Math.round(valueShortTime/6)});
  }
}

function changeLongPerformance()
{
  var valueLongTime = document.getElementById("display-length-input-2").value;
  if (periodTime > valueLongTime)
  {
    chart2.xAxis[0].update({min: (periodTime - valueLongTime), max: periodTime, tickInterval:Math.round(valueLongTime/6)});
  }
  else
  {
    chart2.xAxis[0].update({min: 0, max: valueLongTime, tickInterval:Math.round(valueLongTime/6)});
  }
}