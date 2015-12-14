Template.heatmap.rendered = () ->
  div = '.heatmap'
  drawFloorPlan  div, "images/2nd-floor-plan.svg"
  heatmap = createHeatMap div
  redrawHeatMap metric
  drawSensorLocations div

drawFloorPlan = ( layer_name, src, width=newW, height=newH, alpha=0.3, klass='floorplan_overlay' ) =>
  d3.select( layer_name ).append( 'canvas' )
  .attr( 'class', klass )
  .attr( 'width', width )
  .attr( 'height', height )
  .attr( 'viewBox', '0 0 width height' )
  plan = new Image()
  plan.src = src
  plan.onload = () ->
    canvas = $('.'+klass)
    ctx = canvas[0].getContext( '2d' )
    ctx.globalAlpha = alpha
    ctx.drawImage plan, 50, 0, width, width * plan.height / plan.width
    ctx.globalAlpha = 1.0
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
legendCanvas = document.createElement('canvas');
legendCanvas.width = 100
legendCanvas.height = 10
legendCtx = legendCanvas.getContext('2d')
gradientCfg = {}
updateLegend = (data) ->
  $('min').text = data.min
  $('max').text = data.max
  if data.gradient != gradientCfg
    console.log 'updating legend %s, %s', data.min, data.max
    gradientCfg = data.gradient
    gradient = legendCtx.createLinearGradient(0, 0, 100, 1)
    for key of gradientCfg
      gradient.addColorStop(key, gradientCfg[key])
    legendCtx.fillStyle = gradient
    legendCtx.fillRect(0, 0, 100, 10)
    $('gradient').src = legendCanvas.toDataURL()

createHeatMap = ( layer_name, opacity=[ 0.6, 1.0 ], blur=0.5, width=newW, height=newH) ->
  console.log 'creating heatmap on %s', layer_name
  # create legend
  legendDiv = d3.select( layer_name ).append('div')
  .attr('class', 'legend')
  .style('position', 'absolute')
  .style('top', 0)
  .style('left', 0)
  .attr('width',width)
  .attr('height',height)
  legendDiv.append('span')
  .attr('id','min')
  legendDiv.append('span')
  .attr('id','max')
  legendDiv.append('img')
  .attr('id','gradient')
  .attr('src', '')

  h337.create
    container: document.querySelector layer_name
    radius: profiles[metric].radius
    maxOpacity: opacity[1]
    minOpacity: opacity[0]
    blur: blur
    onExtremaChange: (d) ->
      updateLegend(d)

drawSensorLocations = ( layer_name, radius=3, width=newW, height=newH, klass='sensor_overlay' ) ->
  svg = d3.select( layer_name ).append('svg')
  .style('position', 'absolute')
  .style('top', 0)
  .style('left', 0)
  .attr( 'class', klass )
  .attr( 'width', width )
  .attr( 'height', height )
  canvas = svg.append('g')
  console.log 'drawing sensors'
  console.log newW, newH
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
  .on( 'click', (d,i) ->
    window.open('/sensor/'+d._id+'/timechart')
  )
  .append('title')
  .text((d) -> d._id)
