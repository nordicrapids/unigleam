# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  `var i`
  all_categories = undefined
  all_records = undefined
  categories = undefined
  records = undefined
  if $('.line-chart').length != 0
    categories = $('.line-chart').data('categories').split(', ')
    all_categories = []
    if categories.length >= 0
      all_categories = $('.line-chart').data('categories').split(', ')
    else
      all_categories = [ categories ]
    records = $('.line-chart').data('records')
    all_records = []
    if records.toString().indexOf(',') >= 0
      all_records = $('.line-chart').data('records').split(', ').map(Number)
    else
      all_records = [ records ]
    data_date_utc_format = []
    if categories.length >= 0
      i = 0
      while i < categories.length
        now = categories[i].split('-').map(Number)
        data_date_utc_format.push Date.UTC(now[2], now[1] - 1, now[0])
        i++
    else
      data_date_utc_format = []
    dates_before_30_days = []
    i = 1
    while i <= 30
      d = new Date
      d.setDate d.getDate() - (30 - i)
      utc = d.toJSON().slice(0, 10).split('-')
      utc_format = Date.UTC(utc[0], utc[1] - 1, utc[2])
      if data_date_utc_format.includes(utc_format) == true
        index = data_date_utc_format.indexOf(utc_format)
        dates_before_30_days.push [
          Date.UTC(utc[0], utc[1] - 1, utc[2])
          all_records[index]
        ]
      else
        dates_before_30_days.push [
          Date.UTC(utc[0], utc[1] - 1, utc[2])
          0
        ]
      i++
    $('.line-chart').highcharts
      chart: backgroundColor: '#ED8742'
      title: text: ''
      xAxis:
        type: 'datetime'
        dateTimeLabelFormats: month: '%e. %b'
        title:
          style:
            color: '#FFF'
            fontWeight: 'bold'
          text: 'Dates'
        labels: style: color: '#FFF'
        series: [ {
          color: '#FFF'
          name: 'No of Gleams Casted'
          categories: all_categories
        } ]
      yAxis:
        min: 0
        tickInterval: 1
        title:
          style:
            color: '#FFF'
            fontWeight: 'bold'
          text: 'No of Gleams'
        labels: style: color: '#FFF'
        plotLines: [ {
          value: 0
          width: 1
          color: '#fff'
        } ]
      tooltip: valueSuffix: ''
      series: [ {
        color: '#FFF'
        name: 'No of Gleams Casted'
        data: dates_before_30_days
      } ]
  return
