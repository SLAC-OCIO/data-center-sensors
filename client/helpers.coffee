Template.heatmap.helpers
  width:
    '1000px'
  height:
    '800px'

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
    Router.current().params.id


@normaliseId = (id) ->
  id.substring(8)

@getSensor = (id) ->
  out = {}
  if id of meta
    out = {
      _id: id
      x: meta[id][1]
      y: meta[id][2]
      rack: meta[id][3]
      aisle: meta[id][4]
    }
  out
  
@getSensorIds = () ->
  k for own k of meta
  
@getAllSensors = () ->
  output = []
  for k of meta
    output.push @getSensor k
  output


meta = 
  "5d0000074c6acb28": ["2bf37", 645, 425, "2bf37", "hot", "top", "233d167838a609ee"]
  "c00000074ccb2628": ["2bf38", 656, 425, "2bf38", "hot", "top", "233d167838a609ee"]
  "cc000006bb75dc28": ["2bf39", 667, 425, "2bf39", "hot", "top", "233d167838a609ee"]
  "cd000006bccbf828": ["2bf40", 678, 425, "2bf40", "hot", "top", "233d167838a609ee"]
  "38000006bc02f728": ["2bf41", 689, 425, "2bf41", "hot", "top", "233d167838a609ee"]
  "920000074cd94428": ["2bg37", 645, 443, "2bf37", "cold", "top", "23708c7838a609ee"]
  "8e000006bcc68928": ["2bg38", 656, 443, "2bf38", "cold", "top", "23708c7838a609ee"]
  "7a0000074d915128": ["2bg39", 667, 443, "2bf39", "cold", "top", "23708c7838a609ee"]
  "070000074dd60428": ["2bg40", 678, 443, "2bf40", "cold", "top", "23708c7838a609ee"]
  "3d000006bbf04f28": ["2bg41", 689, 443, "2bf41", "cold", "top", "23708c7838a609ee"]
  "9d000006bc02d928": ["2bj37", 644, 477, "2bj37", "hot", "top", "23715c6938a609ee"]
  "30000006bb6ca928": ["2bj38", 655, 477, "2bj38", "hot", "top", "23715c6938a609ee"]
  "33000006bb64f728": ["2bj39", 666, 477, "2bj39", "hot", "top", "23715c6938a609ee"]
  "bc0000074ca52c28": ["2bj40", 678, 477, "2bj40", "hot", "top", "23715c6938a609ee"]
  "2f000006bc6a0a28": ["2bj41", 689, 477, "2bj41", "hot", "top", "23715c6938a609ee"]
  "235a866938a609ee": ["2ag07", 310, 183, "2ah07", "hot", "right", "self"]
  "23536e6938a609ee": ["2ag08", 321, 183, "2ah08", "hot", "right", "self"]
  "23777c7838a609ee": ["2ag09", 332, 183, "2ah09", "hot", "right", "self"]
  "235c2a6938a609ee": ["2ag12", 365, 183, "2ah12", "hot", "right", "self"]
  "232d836938a609ee": ["2ag13", 380, 183, "2ah13", "hot", "right", "self"]
  "2317896938a609ee": ["2ag14", 391, 183, "2ah14", "hot", "right", "self"]
  "2325857838a609ee": ["2ai07", 310, 203, "2ah07", "cold", "right", "self"]
  "233b206938a609ee": ["2ai08", 321, 203, "2ah08", "cold", "right", "self"]
  "231f527838a609ee": ["2ai09", 332, 203, "2ah09", "cold", "right", "self"]
  "2310786938a609ee": ["2ai12", 365, 203, "2ah12", "cold", "right", "self"]
  "2354436938a609ee": ["2ai13", 380, 203, "2ah13", "cold", "right", "self"]
  "2360656938a609ee": ["2ai14", 391, 203, "2ah14", "cold", "right", "self"]
  "235c537838a609ee": ["2ad19", 438, 152, "2ad18", "cold", "right", "self"]
  "2364557838a609ee": ["2al06", 303, 237, "2am06", "cold", "middle", "self"]
  "2331306938a609ee": ["2al07", 313, 237, "2am07", "cold", "middle", "self"]
  "2315386938a609ee": ["2al08", 323, 237, "2am08", "cold", "left", "self"]
  "231e2d6938a609ee": ["2al10", 344, 237, "2am10", "cold", "left", "self"]
  "2370857838a609ee": ["2al11", 355, 237, "2am11", "cold", "left", "self"]
  "232a896938a609ee": ["2al12", 370, 237, "2am12", "cold", "left", "self"]
  "231e196938a609ee": ["2al13", 385, 237, "2am13", "cold", "middle", "self"]
  "23338b7838a609ee": ["2an06", 303, 256, "2am06", "hot", "right", "self"]
  "2313776938a609ee": ["2an07", 313, 256, "2am07", "hot", "right", "self"]
  "23621b6938a609ee": ["2an08", 323, 256, "2am08", "hot", "right", "self"]
  "236f976938a609ee": ["2an10", 344, 256, "2am10", "hot", "right", "self"]
  "2308637838a609ee": ["2an11", 355, 256, "2am11", "hot", "right", "self"]
  "2361626938a609ee": ["2an12", 370, 256, "2am12", "hot", "right", "self"]
  "23593b6938a609ee": ["2an13", 385, 256, "2am13", "hot", "middle", "self"]
  "2344816938a609ee": ["2ap06", 299, 276, "2aq06", "hot", "right", "self"]
  "2357b27838a609ee": ["2ap07", 310, 276, "2aq07", "hot", "right", "self"]
  "234a577838a609ee": ["2ap08", 322, 276, "2aq08", "hot", "right", "self"]
  "230d716938a609ee": ["2ap09", 332, 276, "2aq09", "hot", "right", "self"]
  "235a4d7838a609ee": ["2ap11", 355, 276, "2aq11", "hot", "right", "self"]
  "2335446938a609ee": ["2ap12", 366, 276, "2aq12", "hot", "right", "self"]
  "2303746938a609ee": ["2ap13", 378, 276, "2aq13", "hot", "right", "self"]
  "235c747838a609ee": ["2ap14", 390, 276, "2aq14", "hot", "right", "self"]
  "2378926938a609ee": ["2ar06", 299, 291, "2aq06", "cold", "middle", "self"]
  "232d2b6938a609ee": ["2ar07", 310, 291, "2aq07", "cold", "middle", "self"]
  "23158c6938a609ee": ["2ar08", 322, 291, "2aq08", "cold", "right", "self"]
  "236b5d7838a609ee": ["2ar09", 332, 291, "2aq09", "cold", "right", "self"]
  "2343a07838a609ee": ["2ar11", 355, 291, "2aq11", "cold", "right", "self"]
  "2362a67838a609ee": ["2ar12", 366, 291, "2aq12", "cold", "right", "self"]
  "23534b6938a609ee": ["2ar13", 378, 291, "2aq13", "cold", "right", "self"]
  "2311836938a609ee": ["2ar14", 390, 291, "2aq14", "cold", "right", "self"]
  "233c957838a609ee": ["2bc02", 257, 406, "2bd02", "hot", "left", "self"]
  "2323296938a609ee": ["2bc03", 268, 406, "2bd03", "hot", "left", "self"]
  "2360a97838a609ee": ["2bc04", 279, 406, "2bd04", "hot", "left", "self"]
  "2345767838a609ee": ["2bc06", 300, 406, "2bd06", "hot", "left", "self"]
  "23441a6938a609ee": ["2bc07", 311, 406, "2bd07", "hot", "left", "self"]
  "235c947838a609ee": ["2bc08", 322, 406, "2bd08", "hot", "left", "self"]
  "23531b6938a609ee": ["2be02", 257, 422, "2bd02", "cold", "left", "self"]
  "231478068fb7bdee": ["2be03", 268, 422, "2bd03", "cold", "left", "self"]
  "233d167838a609ee": ["2be04", 279, 422, "2bd04", "cold", "left", "self"]
  "2359817838a609ee": ["2be06", 300, 422, "2bd06", "cold", "left", "self"]
  "23715c6938a609ee": ["2be07", 311, 422, "2bd07", "cold", "left", "self"]
  "232b857838a609ee": ["2ad26", 520, 150, "2ae26", "hot", "left", "self"]
  "231a7a7838a609ee": ["2ad27", 532, 150, "2ae27", "hot", "left", "self"]
  "235c537838a609ee": ["2ad28", 544, 150, "2ae28", "hot", "left", "self"]
  "237b826938a609ee": ["2ad29", 556, 150, "2ae29", "hot", "left", "self"]
  "2371977838a609ee": ["2ad30", 568, 150, "2ae30", "hot", "left", "self"]
  "2347527838a609ee": ["2ad31", 580, 150, "2ae31", "hot", "left", "self"]
  "235c757838a609ee": ["2ad32", 592, 150, "2ae32", "hot", "left", "self"]
  "2315686938a609ee": ["2af26", 520, 166, "2ae26", "cold", "left", "self"]
  "23605d7838a609ee": ["2af27", 532, 166, "2ae27", "cold", "left", "self"]
  "236e727838a609ee": ["2af28", 544, 166, "2ae28", "cold", "left", "self"]
  "23507e7838a609ee": ["2af29", 556, 166, "2ae29", "cold", "right", "self"]
  "2377a1068fb7bdee": ["2af30", 568, 166, "2ae30", "cold", "right", "self"]
  "2326637838a609ee": ["2af31", 580, 166, "2ae31", "cold", "right", "self"]
  "2312806938a609ee": ["2af32", 592, 166, "2ae32", "cold", "right", "self"]
  "10000006bb254728": ["2ah25", 511, 192, "2ai25", "hot", "top", "2347527838a609ee "]
  "7a000006bcbfad28": ["2ah26", 523, 192, "2ai26", "hot ", "top", "2347527838a609ee "]
  "9e0000074dcd9b28": ["2ah27", 535, 192, "2ai27", "hot", "top", "2347527838a609ee "]
  "ff0000074bfb7828": ["2ah28", 548, 192, "2ai28", "hot", "top", "2347527838a609ee "]
  "1c000006bc104328": ["2ah29", 561, 192, "2ai29", "hot", "top", "2347527838a609ee "]
  "140000074bfd2b28": ["2ah30", 573, 192, "2ai30", "hot", "top", "2347527838a609ee "]
  "82000006bc0f0828": ["2ah31", 586, 192, "2ai31", "hot", "top", "2347527838a609ee "]
  "7a000006baff7228": ["2ah32", 598, 192, "2ai32", "hot", "top", "2347527838a609ee "]
  "23448c6938a609ee": ["2aj24", 499, 209, "2ai24", "cold", "right", "self"]
  "23348b7838a609ee": ["2aj25", 511, 209, "2ai25", "cold", "right", "self"]
  "2344ae7838a609ee": ["2aj26", 523, 209, "2ai26", "cold", "right", "self"]
  "2352926938a609ee": ["2aj27", 535, 209, "2ai27", "cold", "right", "self"]
  "fc0000074dd2fd28": ["2ak24", 499, 226, "2al24", "cold", "top", "235c757838a609ee"]
  "870000074d6bbb28": ["2ak25", 510, 226, "2al25", "cold", "top", "235c757838a609ee"]
  "e0000006bc20ec28": ["2ak26", 521, 226, "2al26", "cold", "top", "235c757838a609ee"]
  "c1000006bbdcc528": ["2ak27", 533, 226, "2al27", "cold", "top", "235c757838a609ee"]
  "6a000006bc0cb028": ["2ak28", 546, 226, "2al28", "cold", "top", "235c757838a609ee"]
  "6a0000074bcb6528": ["2ak29", 559, 226, "2al29", "cold", "top", "235c757838a609ee"]
  "24000006bb911a28": ["2ak30", 570, 226, "2al30", "cold", "top", "235c757838a609ee"]
  "eb000006bceaf628": ["2ak31", 581, 226, "2al31", "cold", "top", "235c757838a609ee"]
  "f0000006dcb82528": ["2am24", 499, 242, "2al24", "hot", "top", "232b857838a609ee"]
  "4d000006dd8d7828": ["2am25", 510, 242, "2al25", "hot", "top", "232b857838a609ee"]
  "31000006dd9f4a28": ["2am26", 521, 242, "2al26", "hot", "top", "232b857838a609ee"]
  "92000006de26c628": ["2am27", 533, 242, "2al27", "hot", "top", "232b857838a609ee"]
  "70000006dcf60928": ["2am28", 546, 242, "2al28", "hot", "top", "232b857838a609ee"]
  "cb000006dd392328": ["2am29", 559, 242, "2al29", "hot", "top", "232b857838a609ee"]
  "4d000006dd340728": ["2am30", 570, 242, "2al30", "hot", "top", "232b857838a609ee"]
  "3a000006dd20b928": ["2am31", 581, 242, "2al31", "hot", "top", "232b857838a609ee"]
  "e30000074d1e0f28": ["2ao24", 502, 262, "2ap24", "hot", "top", "2315686938a609ee"]
  "ea000006bc6a5f28": ["2ao25", 513, 262, "2ap25", "hot", "top", "2315686938a609ee"]
  "93000006bc66d928": ["2ao26", 524, 262, "2ap26", "hot", "top", "2315686938a609ee"]
  "9e000006bc10f428": ["2ao27", 534, 262, "2ap27", "hot", "top", "2315686938a609ee"]
  "a9000006bac3a428": ["2ao28", 544, 262, "2ap28", "hot", "top", "2315686938a609ee"]
  "b2000006bc7c0628": ["2ao29", 555, 262, "2ap29", "hot", "top", "2315686938a609ee"]
  "1c000006bb627428": ["2ao30", 566, 262, "2ap30", "hot", "top", "2315686938a609ee"]
  "c8000006bc23a228": ["2ao31", 577, 262, "2ap31", "hot", "top", "2315686938a609ee"]
  "42000006dcab8128": ["2aq24", 502, 280, "2ap24", "cold", "top", "232b5e7838a609ee"]
  "f6000006dd9f0c28": ["2aq25", 513, 280, "2ap25", "cold", "top", "232b5e7838a609ee"]
  "0c000006dc8cee28": ["2aq26", 524, 280, "2ap26", "cold", "top", "232b5e7838a609ee"]
  "6e000006dd181f28": ["2aq27", 534, 280, "2ap27", "cold", "top", "232b5e7838a609ee"]
  "58000006ddf9b328": ["2aq28", 544, 280, "2ap28", "cold", "top", "232b5e7838a609ee"]
  "9a000006de152328": ["2aq29", 555, 280, "2ap29", "cold", "top", "232b5e7838a609ee"]
  "a9000006dc75a928": ["2aq30", 566, 280, "2ap30", "cold", "top", "232b5e7838a609ee"]
  "ba000006d6046828": ["2aq31", 577, 280, "2ap31", "cold", "top", "232b5e7838a609ee"]
