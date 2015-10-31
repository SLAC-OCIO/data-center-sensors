
Template.sensor_timechart.helpers
  grafana_uri: () ->
    "http://grafana.slac.stanford.edu"
  dashboard: () ->
    "sensor"
  panel_number: () ->
    "1"
  id: () ->
    Router.current().params.id

