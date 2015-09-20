d3 = require 'd3'

module.exports.initTickChart = (chart, $container) ->
  width = $container.width()
  height = $container.height()
  margin = {top: 20, right: 20, bottom: 30, left: 50}

  parseDate = d3.time.format("%d-%b-%y").parse

  x = d3.time.scale().range [0, width]
  y = d3.scale.linear().range [height, 0]

  xAxis = d3.svg.axis().scale(x).orient("bottom")
  yAxis = d3.svg.axis().scale(y).orient("left")

  line = d3.svg.line()
    .x((point) -> x(Date.parse(point.get('timestamp'))))
    .y((point) -> y(parseInt(point.get('close'))))

  svg = d3.select("#chart")
    .append("svg")
    .attr("width", $container.width())
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(#{margin.left}, #{margin.top})")
    .attr('viewBox',"0 0 #{Math.min(width,height)} #{Math.min(width,height)}" )
    .attr('preserveAspectRatio','xMinYMin')

  x.domain d3.extent chart.models, (point) -> Date.parse(point.get('timestamp'))
  y.domain d3.extent chart.models, (point) -> parseInt(point.get('close'))

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Å")

  svg.append("path")
      .datum(chart.models)
      .attr("class", "line")
      .attr("d", line)