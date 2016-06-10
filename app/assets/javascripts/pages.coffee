# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.line-chart').highcharts
    chart:
      backgroundColor: "#EE8742",
    title:
      text: ''
    xAxis: categories: [
      'Jan'
      'Feb'
      'Mar'
      'Apr'
      'May'
      'Jun'
      'Jul'
      'Aug'
      'Sep'
      'Oct'
      'Nov'
      'Dec'
    ]
    xAxis:
      title: text: ''
      labels: style: color: "#FFF"
    yAxis:
      title: text: ''
      labels: style: color: "#FFF"
      plotLines: [ {
        value: 0
        width: 1
        color: '#fff'
      } ]
    tooltip: valueSuffix: '°C'
    series: [
      {
        color: '#FFF',
        name: 'Gleams casted'
        data: [
          7.0
          6.9
          9.5
          14.5
          18.2
          21.5
          25.2
          26.5
          23.3
          18.3
          13.9
          9.6
        ]
      }
    ]
  return
