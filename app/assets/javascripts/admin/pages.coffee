# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if $('.line-chart').length != 0

    # all records
    categories = $(".line-chart").data("categories")
    all_categories = []
    if (categories.toString().indexOf(",") >= 0)
      all_categories = $(".line-chart").data("categories")
    else
      all_categories = [categories]

    # all records
    records = $(".line-chart").data("records")
    all_records = []
    if (records.toString().indexOf(",") >= 0)
      all_records = $(".line-chart").data("records").split(", ").map(Number)
    else
      all_records = [records]

    $('.line-chart').highcharts
      chart:
        backgroundColor: "#EE8742",
      title:
        text: ''
      xAxis:
        title: text: ''
        labels: style: color: "#FFF"
        categories: all_categories
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
          data: all_records
        }
      ]
  return
