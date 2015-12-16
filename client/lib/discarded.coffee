###
@gradientCfg = {}
# create legend
@createLegend = (layer_name) ->
  heatDiv = d3.select( layer_name ).append('canvas')
  .attr('class', 'legendCanvas')
  .style('position', 'absolute')
  .style('bottom', 0)
  .style('right', 0)
  .attr('width',100)
  .attr('height',10)
  .style('background-color', '#000000')
  heatDiv.append('span')
  .attr('id','min')
  heatDiv.append('span')
  .attr('id','max')
  heatDiv.append('img')
  .attr('id','gradient')
@createHeatCanvas = ( width=dcscope.w, height=dcscope.h ) ->
  heatCanvas = document.createElement('canvas')
  heatCanvas.width = width
  heatCanvas.height = height
  @heatCtx = heatCanvas.getContext('2d')

#should the data change extremely, update the heatcanvas
@updateHeatCanvas = (data) ->
  $('min').text = data.min
  $('max').text = data.max
  if data.gradient != gradientCfg
    console.log 'updating heatmap %s, %s', data.min, data.max
    gradientCfg = data.gradient
    gradient = heatCtx.createLinearGradient(0, 0, 100, 1)
    for key of gradientCfg
      gradient.addColorStop(key, gradientCfg[key])
    heatCtx.fillStyle = gradient
    heatCtx.fillRect(0, 0, dcscope.w, dcscope.h)
    $('gradient').src = heetCanvas.toDataURL()



zoomed = ->
heatmap.attr "transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")"
dragstarted = (d) ->
d3.event.sourceEvent.stopPropagation()
d3.select(this).classed "dragging", true
dragged = (d) ->
d3.select(this).attr("cx", d.x = d3.event.x).attr "cy", d.y = d3.event.y
dragended = (d) ->
d3.select(this).classed "dragging", false
zoom = d3.behavior.zoom().scaleExtent([ 1, 10 ]).on("zoom", zoomed)
drag = d3.behavior.drag().origin((d) ->
d
).on("dragstart", dragstarted).on("drag", dragged).on("dragend", dragended)

###