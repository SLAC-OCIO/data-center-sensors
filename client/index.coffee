heatmap = null
data = {}
metric = 'temp'


profiles = 
  'temp':
    max: 50
    radius: 13
    gradient: 
      0.0: 'gray'
      0.3: 'cyan'
      0.5: 'yellow'
      0.7: 'orange'
      0.9: 'red'
  'pressure':
    max: 1500
    radius: 13
    gradient:
      0.0: 'gray'
      0.5: 'cyan'
      0.8: 'yellow'
      0.6: 'orange'

drawFloorPlan = ( layer_name, src, translate=[0,0], scale=[1,1], width=1000, height=800, alpha=0.3, klass='floorplan_overlay' ) ->
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
    ctx.save()
    ctx.clearRect(0, 0, width, height);
    ctx.translate( translate[0], translate[1] )
    ctx.scale( scale[0], scale[1] ) 
    ctx.globalAlpha = alpha
    ctx.drawImage plan, 50, 0, width, width * plan.height / plan.width
    ctx.globalAlpha = 1.0
    ctx.restore()

last_metric = null
redrawHeatMap = ( metric ) ->
  if heatmap?
    if last_metric != metric
      console.log 'redraw: %o with %s', heatmap, metric
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

createHeatMap = ( layer_name, opacity=[ 0.6, 1.0 ], blur=0.5 ) ->
  console.log 'creating heatmap on %s', layer_name
  # create legend
  legendDiv = d3.select( layer_name ).append('div')
    .attr('class', 'legend')
    .style('position', 'absolute')
    .style('top', 0)
    .style('left', 0)
    .attr('width',100)
    .attr('height',10)
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

drawSensorLocations = ( layer_name, radius=3, width=1000, height=800, klass='sensor_overlay' ) ->
  svg = d3.select( layer_name ).append('svg')
    .style('position', 'absolute')
    .style('top', 0)
    .style('left', 0)
    .attr( 'class', klass )
    .attr( 'width', width )
    .attr( 'height', height )
    .call d3.behavior.zoom().on \
        "zoom", () -> 
            dx = d3.event.translate[0]
            dy = d3.event.translate[1]
            s1 = d3.event.scale
            s2 = d3.event.scale
            # update sensor overlay
            svg.attr "transform", "translate(" + d3.event.translate + ")" + " scale(" + d3.event.scale + ")"
            # update heatmap (not working)
            ht = d3.select( "canvas.heatmap-canvas" ).node().getContext("2d")
            # console.log "ht: %o %s %s (%s)", ht, dx, dy, metric
            # ht.translate( dx, dy )
            # update floor plan
            drawFloorPlan( '.heatmap',  "images/2nd-floor-plan.svg", [dx, dy], [s1,s2] )
            
    .append('g')
  
  console.log 'drawing sensors'
  svg.selectAll('circle')
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
          # console.log "clicked on %o", d
          window.open('/sensor/'+d._id+'/timechart')
      )
      .append('title')
        .text((d) -> d._id)

    
 
Template.heatmap.rendered = () ->
  div = '.heatmap'
  drawFloorPlan  div, "images/2nd-floor-plan.svg"
  heatmap = createHeatMap div
  redrawHeatMap metric
  drawSensorLocations div

    
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


