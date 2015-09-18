heatmap = null
data = {}
metric = 'temp'


profiles = 
  'temp':
    max: 50
    gradient: 
      0.0: 'gray'
      0.2: 'cyan'
      0.4: 'yellow'
      0.6: 'orange'
      0.8: 'red'
  'pressure':
    max: 1500
    gradient:
      0.0: 'gray'
      0.5: 'cyan'
      0.8: 'yellow'
      0.6: 'orange'


drawFloorPlan = ( layer_name, src, width=1000, height=800, alpha=0.3, klass='floorplan_overlay' ) ->

  d3.select( layer_name ).append( 'canvas' )
    .style('top', 0)
    .style('left', 0)
    .attr( 'class', klass )
    .attr( 'width', width )
    .attr( 'height', height )

  plan = new Image()
  plan.src = src
  plan.onload = () -> 
    # canvas = layer
    canvas = $('.'+klass)
    ctx = canvas[0].getContext( '2d' )
    ctx.globalAlpha = alpha
    ctx.drawImage plan, 50, 0, width, width * plan.height / plan.width
    ctx.globalAlpha = 1.0

# redraw = ( metric, sensors_layer=$('#contrast_circle') ) ->
redraw = ( metric ) ->
  drawHeatMap metric 

regenData = ( metric ) ->
  tuples = []
  for id in getSensorIds()
    t = getSensor id 
    t.value = if id of data then parseFloat data[id][metric] else 0
    tuples.push t
  tuples

drawHeatMap = ( metric ) ->
  if heatmap?
    # console.log 'redraw: %o', heatmap
    heatmap.setData
      max: profiles[metric].max
      min: 0
      data: regenData metric

initHeatMap = ( layer_name, gradient={ 0.0: 'gray', 0.2: 'cyan', 0.4: 'yellow', 0.6: 'orange', 0.8: 'red' }, radius=13, opacity=[ 0.6, 1.0 ], blur=0.5 ) ->
  console.log 'creating heatmap on %s', layer_name
  h337.create
    container: document.querySelector layer_name
    gradient: gradient
    radius: radius
    maxOpacity: opacity[1]
    minOpacity: opacity[0]
    blur: blur


drawSensorLocations = ( layer_name, radius=3, width=1000, height=800, klass='sensor_overlay' ) ->
  svg = d3.select( layer_name ).append('svg')
    .style('position', 'absolute')
    .style('top', 0)
    .style('left', 0)
    .attr( 'class', klass )
    .attr( 'width', width )
    .attr( 'height', height )
  
  canvas = svg.append('g')
  console.log 'drawing sensors'
  canvas.selectAll('circle')
    .data( getAllSensors() ).enter()
    .append('circle')
      .attr('class', 'sensor')
      .attr('id', (d) -> d._id )
      .attr('cx', (d) -> d.x )
      .attr('cy', (d) -> d.y)
      .attr('r', radius )
      .attr('fill', 'blue')
      .attr('title', (d) -> d._id )
      .attr('onclick', (d) -> "console.log('"+d._id+"')")
      .append('title')
        .text((d) -> d._id)
    
Template.sensor_list.rendered = () ->
  div = '.heatmap'
  drawFloorPlan  div, "images/2nd-floor-plan.svg"
  heatmap = initHeatMap div
  redraw metric
  drawSensorLocations div
  
Sensors.find().observe
  added: (datum) ->
    i = normaliseId( datum._id )
    # console.log 'sensor added: %s -> %s: %o', datum._id, i, datum
    data[i] = datum
    redraw metric
  changed: (datum) ->
    i = normaliseId( datum._id )
    # console.log 'sensor changed: %s -> %s', datum._id, i
    data[i] = datum
    redraw metric


