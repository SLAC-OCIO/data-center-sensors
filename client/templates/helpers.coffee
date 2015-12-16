Template.heatmap.rendered = () ->
  div = '.heatmap'
  drawFloorPlan  div, "img/2nd-floor-plan.svg"
  heatmap = createHeatMap div
  redrawHeatMap metric
  drawSensorLocations div

Template.heatmap.events =() ->
  resize: () ->
    console.log "cheese"

Template.sensor_table.helpers
  settings: () ->
    return {
      collection: Sensors
      rowsPerPage: 100
      showFilter: true
      fields: [
        { key: '_id', label: 'id', fn: (v,o) -> normaliseId v },
        { key: '_id', label: 'rack', fn: (v,o) -> (getSensor normaliseId v).rack },
        { key: '_id', label: 'aisle', fn: (v,o) -> (getSensor normaliseId v).aisle },
        { key: 'temp', label: 'temperature (°C)' },
        { key: 'humidity', label: 'humidity (%)' },
        { key: 'pressure', label: 'pressure (hPa)' },
        { key: 'lux', label: 'brightness (lux)' },
        { key: 'rssi', label: 'rssi (dBm)' },
        { key: 'ts', label: 'updated', tmpl: Template.sensor_updated }
      ]
    }

Template.sensor_list.helpers
  sensors: () ->
    Sensors.find()

Template.sensor_item.helpers
  get: (id) ->
    {}
  getRack: (id) ->
    d = getSensor normaliseId id
    d.rack
  getHotCold: (id) ->
    d = getSensor normaliseId id
    d.aisle


Template.sensor_timechart.helpers
  grafana_uri: () ->
    "http://grafana.slac.stanford.edu"
  dashboard: () ->
    "sensor"
  panel_number: () ->
    "1"
  id: () ->
    FlowRouter.getParam().id

Template.sensor_timechart.onCreated ->
  self = this
  self.autorun ->
    id = FlowRouter.getParam "id",id