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
