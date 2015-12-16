@drawFloorPlan = ( layer_name, src, width=dcscope.w, height=dcscope.h, alpha=0.3, klass='floorplan_overlay' ) ->
  console.log("drawing")
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
    ctx.drawImage plan, 0, 0, width, width * plan.height / plan.width
    ctx.globalAlpha = 1.0

legendCanvas = document.createElement('canvas')
legendCanvas.width = 100
legendCanvas.height = 10
legendCtx = legendCanvas.getContext('2d')

@drawSensorLocations = ( layer_name, radius=3, width=dcscope.w, height=dcscope.h, klass='sensor_overlay' ) ->
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
      .append('title')
      .text((d) -> d._id)
      .on( 'click', (d,i) ->
        Modal.show('sensor_timechart','/sensor/'+d._id+'/timechart')
      )

#This creates the radial blurs
@createHeatMap = ( layer_name, opacity=[ 0.6, 1.0 ], blur=0.5) ->
  heatDiv = d3.select ( layer_name ).append('div')
    .attr('class', 'heatdiv')
    .style('position', 'absolute')
    .style('top', 0)
    .style('left', 0)
    .attr('width',100)
    .attr('height',10)
  heatDiv.append('span')
    .attr('id','min')
  heatDiv.append('span')
    .attr('id','max')
  heatDiv.append('img')
    .attr('id','gradient')
    .attr('src', '')
  h337.create
    container: document.querySelector layer_name
    maxOpacity: opacity
    radius: profiles[metric].radius
    gradient: profiles[metric].gradient
    blur: blur
  heatmap.setData
    max: profiles[metric].max
    min: 0
    data: regenData metric

last_metric = null

@redrawHeatMap = ( metric ) ->
  if heatmap?
    if last_metric != metric
      heatmap.configure
        gradient: profiles[metric].gradient
        radius: profiles[metric].radius
    heatmap.setData
      max: profiles[metric].max
      min: 0
      data: regenData metric
    last_metric = metric

regenData = ( metric ) ->
  tuples = []
  for id in getSensorIds()
    t = getSensor id
    t.value = if id of data then parseFloat data[id][metric] else null
    tuples.push t
  tuples

Sensors.find().observe
  added: (datum) ->
    i = normaliseId( datum._id )
    now = (new Date).getTime() / 1000
    diff = now - datum.ts
    console.log 'sensor added: %s %o', i, datum
    # don't add if too old (5mins?)
    if diff < 300.0
      data[i] = datum
      redrawHeatMap metric
  changed: (datum) ->
    i = normaliseId( datum._id )
    # console.log 'sensor changed: %s -> %s', datum._id, i
    data[i] = datum
    redrawHeatMap metric
