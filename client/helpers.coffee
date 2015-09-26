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
  "2303746938a609ee":	[ "2ap13",	378,	276,	"2aq13",	"hot",	"right" ]																				
  "2308637838a609ee":	[ "2an11",	355,	256,	"2am11",	"hot",	"right" ]																				
  "230d716938a609ee":	[ "2ap09",	332,	276,	"2aq09",	"hot",	"right" ]																				
  "2310786938a609ee":	[ "2ai12",	365,	203,	"2ah12",	"cold",	"right" ]																				
  "2311836938a609ee":	[ "2ar14",	390,	291,	"2aq14",	"cold",	"right" ]																				
  "2312806938a609ee":	[ "2af32",	592,	166,	"2ae32",	"cold",	"right" ]																				
  "2313776938a609ee":	[ "2an07",	313,	256,	"2am07",	"hot",	"right" ]																				
  "231478068fb7bdee":	[ "2be03",	268,	422,	"2bd03",	"cold",	"left" ]																				
  "2315386938a609ee":	[ "2al08",	323,	237,	"2am08",	"cold",	"left" ]																				
  "2315686938a609ee":	[ "2af26",	520,	166,	"2ae26",	"cold",	"left" ]																				
  "23158c6938a609ee":	[ "2ar08",	322,	291,	"2aq08",	"cold",	"right" ]																				
  "2317896938a609ee":	[ "2ag14",	391,	183,	"2ah14",	"hot",	"right" ]																				
  "231a7a7838a609ee":	[ "2ad27",	532,	150,	"2ae27",	"hot",	"left" ]																				
  "231e196938a609ee":	[ "2al13",	385,	237,	"2am13",	"cold",	"middle" ]																				
  "231e2d6938a609ee":	[ "2al10",	344,	237,	"2am10",	"cold",	"left" ]																				
  "231f527838a609ee":	[ "2ai09",	332,	203,	"2ah09",	"cold",	"right" ]																				
  "2323296938a609ee":	[ "2bc03",	268,	406,	"2bd03",	"hot",	"left" ]																				
  "2325857838a609ee":	[ "2ai07",	310,	203,	"2ah07",	"cold",	"right" ]																				
  "2326637838a609ee":	[ "2af31",	580,	166,	"2ae31",	"cold",	"right" ]																				
  "232a896938a609ee":	[ "2al12",	370,	237,	"2am12",	"cold",	"left" ]																				
  "232b857838a609ee":	[ "2ad26",	520,	150,	"2ae26",	"hot",	"left" ]																				
  "232d2b6938a609ee":	[ "2ar07",	310,	291,	"2aq07",	"cold",	"middle" ]																				
  "232d836938a609ee":	[ "2ag13",	380,	183,	"2ah13",	"hot",	"right" ]																				
  "2331306938a609ee":	[ "2al07",	313,	237,	"2am07",	"cold",	"middle" ]																				
  "23338b7838a609ee":	[ "2an06",	303,	256,	"2am06",	"hot",	"right" ]																				
  "23348b7838a609ee":	[ "2aj25",	511,	209,	"2ai25",	"cold",	"right" ]																				
  "2335446938a609ee":	[ "2ap12",	366,	276,	"2aq12",	"hot",	"right" ]																				
  "233b206938a609ee":	[ "2ai08",	321,	203,	"2ah08",	"cold",	"right" ]																				
  "233c957838a609ee":	[ "2bc02",	257,	406,	"2bd02",	"hot",	"left" ]																				
  "233d167838a609ee":	[ "2be04",	279,	422,	"2bd04",	"cold",	"left" ]																				
  "2343a07838a609ee":	[ "2ar11",	355,	291,	"2aq11",	"cold",	"right" ]																				
  "23441a6938a609ee":	[ "2bc07",	311,	406,	"2bd07",	"hot",	"left" ]																				
  "2344816938a609ee":	[ "2ap06",	299,	276,	"2aq06",	"hot",	"right" ]																				
  "23448c6938a609ee":	[ "2aj24",	499,	209,	"2ai24",	"cold",	"right" ]																				
  "2344ae7838a609ee":	[ "2aj26",	523,	209,	"2ai26",	"cold",	"right" ]																				
  "2345767838a609ee":	[ "2bc06",	300,	406,	"2bd06",	"hot",	"left" ]																				
  "2347527838a609ee":	[ "2ad31",	580,	150,	"2ae31",	"hot",	"left" ]																				
  "234a577838a609ee":	[ "2ap08",	322,	276,	"2aq08",	"hot",	"right" ]																				
  "234da67838a609ee":	[ "2ah24",	499,	192,	"2ai24",	"hot",	"left" ]																				
  "2350386938a609ee":	[ "2ah27",	535,	192,	"2ai27",	"hot",	"right" ]																				
  "23507e7838a609ee":	[ "2af29",	556,	166,	"2ae29",	"cold",	"right" ]																				
  "2352926938a609ee":	[ "2aj27",	535,	209,	"2ai27",	"cold",	"right" ]																				
  "23531b6938a609ee":	[ "2be02",	257,	422,	"2bd02",	"cold",	"left" ]																				
  "23534b6938a609ee":	[ "2ar13",	378,	291,	"2aq13",	"cold",	"right" ]																				
  "23536e6938a609ee":	[ "2ag08",	321,	183,	"2ah08",	"hot",	"right" ]																				
  "2354436938a609ee":	[ "2ai13",	380,	203,	"2ah13",	"cold",	"right" ]																				
  "2357b27838a609ee":	[ "2ap07",	310,	276,	"2aq07",	"hot",	"right" ]																				
  "23593b6938a609ee":	[ "2an13",	385,	256,	"2am13",	"hot",	"middle" ]																				
  "2359817838a609ee":	[ "2be06",	300,	422,	"2bd06",	"cold",	"left" ]																				
  "235a4d7838a609ee":	[ "2ap11",	355,	276,	"2aq11",	"hot",	"right" ]																				
  "235a866938a609ee":	[ "2ag07",	310,	183,	"2ah07",	"hot",	"right" ]																				
  "235c2a6938a609ee":	[ "2ag12",	365,	183,	"2ah12",	"hot",	"right" ]																				
  "235c537838a609ee":	[ "2ad19",	438,	152,	"2ad18",	"cold",	"right" ]																				
  "235c537838a609ee":	[ "2ad28",	544,	150,	"2ae28",	"hot",	"left" ]																				
  "235c747838a609ee":	[ "2ap14",	390,	276,	"2aq14",	"hot",	"right" ]																				
  "235c757838a609ee":	[ "2ad32",	592,	150,	"2ae32",	"hot",	"left" ]																				
  "235c947838a609ee":	[ "2bc08",	322,	406,	"2bd08",	"hot",	"left" ]																				
  "23605d7838a609ee":	[ "2af27",	532,	166,	"2ae27",	"cold",	"left" ]																				
  "2360656938a609ee":	[ "2ai14",	391,	203,	"2ah14",	"cold",	"right" ]																				
  "2360a97838a609ee":	[ "2bc04",	279,	406,	"2bd04",	"hot",	"left" ]																				
  "2361626938a609ee":	[ "2an12",	370,	256,	"2am12",	"hot",	"right" ]																				
  "23621b6938a609ee":	[ "2an08",	323,	256,	"2am08",	"hot",	"right" ]																				
  "2362a67838a609ee":	[ "2ar12",	366,	291,	"2aq12",	"cold",	"right" ]																				
  "2364557838a609ee":	[ "2al06",	303,	237,	"2am06",	"cold",	"middle" ]																				
  "236b5d7838a609ee":	[ "2ar09",	332,	291,	"2aq09",	"cold",	"right" ]																				
  "236d947838a609ee":	[ "2ah25",	511,	192,	"2ai25",	"hot",	"left" ]																				
  "236e727838a609ee":	[ "2af28",	544,	166,	"2ae28",	"cold",	"left" ]																				
  "236f976938a609ee":	[ "2an10",	344,	256,	"2am10",	"hot",	"right" ]																				
  "2370857838a609ee":	[ "2al11",	355,	237,	"2am11",	"cold",	"left" ]																				
  "23715c6938a609ee":	[ "2be07",	311,	422,	"2bd07",	"cold",	"left" ]																				
  "2371977838a609ee":	[ "2ad30",	568,	150,	"2ae30",	"hot",	"left" ]																				
  "23777c7838a609ee":	[ "2ag09",	332,	183,	"2ah09",	"hot",	"right" ]																				
  "2377a1068fb7bdee":	[ "2af30",	568,	166,	"2ae30",	"cold",	"right" ]																				
  "2378926938a609ee":	[ "2ar06",	299,	291,	"2aq06",	"cold",	"middle" ]																				
  "237b826938a609ee":	[ "2ad29",	556,	150,	"2ae29",	"hot",	"left" ]																				
  "23867c7838a609ee":	[ "2ah26",	523,	192,	"2ai26",	"hot", 	"left" ]																				
  
