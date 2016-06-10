# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.line-chart').highcharts
    chart:
      backgroundColor: "#EE8742",
    title:
      text: ''
    xAxis:
      title: text: ''
      labels: style: color: "#FFF"
      categories: $(".line-chart").data("categories").split(", ")
    yAxis:
      title: text: ''
      labels: style: color: "#FFF"
      plotLines: [ {
        value: 0
        width: 1
        color: '#fff'
      } ]
    tooltip: valueSuffix: ''
    series: [
      {
        color: '#FFF',
        name: 'Gleams casted'
        data: $(".line-chart").data("records").split(", ").map(Number)
      }
    ]
  return
