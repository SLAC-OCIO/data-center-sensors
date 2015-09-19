Template.heatmap.helpers
  width: '1000px'
  height: '800px'

Template.sensor_table.helpers
  settings: () ->
    return {
    collection: Sensors
    rowsPerPage: 100
    showFilter: true
    fields: [
      { key: '_id', label: 'id' },
      { key: 'temp', label: 'temperature (degC)' },
      { key: 'humidity', label: 'humidity (%)' },
      { key: 'pressure', label: 'hPa' },
      { key: 'lux', label: 'lux' },
      { key: 'rssi', label: 'rssi (dBm)' },
      { key: 'ts', label: 'timestamp' }
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
  "235a866938a609ee": [ "2ag07",	310,	183,	"2ah07",	"hot",	"right" ]
  "23536e6938a609ee": [ "2ag08",	321,	183,	"2ah08",	"hot",	"right" ]
  "23777c7838a609ee": [ "2ag09",	332,	183,	"2ah09",	"hot",	"right" ]
  "235c2a6938a609ee": [ "2ag12",	365,	183,	"2ah12",	"hot",	"right" ]
  "2323296938a609ee": [ "2ag13",	380,	183,	"2ah13",	"hot",	"right" ]
  "2317896938a609ee": [ "2ag14",	391,	183,	"2ah14",	"hot",	"right" ]
  "2325857838a609ee": [ "2ai07",	310,	203,	"2ah07",	"cold",	"right" ]
  "233b206938a609ee": [ "2ai08",	321,	203,	"2ah08",	"cold",	"right" ]
  "231f527838a609ee": [ "2ai09",	332,	203,	"2ah09",	"cold",	"right" ]
  "2310786938a609ee": [ "2ai12",	365,	203,	"2ah12",	"cold",	"right" ]
  "2354436938a609ee": [ "2ai13",	380,	203,	"2ah13",	"cold",	"right" ]
  "2360656938a609ee": [ "2ai14",	391,	203,	"2ah14",	"cold",	"right" ]
  "231a7a7838a609ee": [ "2ag17",	425,	185,	"2ag17",	"hot",	"right" ]
  "2377a1068fb7bdee": [ "2ai17",	425,	207,	"2ai18",	"hot",	"right" ]
  "235c537838a609ee": [ "2ad19",	438,	152,	"2ad18",	"cold",	"right" ]
  "236e727838a609ee": [ "2ag19",	438,	185,	"2ag19",	"cold",	"middle" ]
  "23507e7838a609ee": [ "2ai19",	438,	207,	"2ai18",	"cold",	"middle" ]
  "2364557838a609ee": [ "2al06",	303,	237,	"2am06",	"cold",	"middle" ]
  "2331306938a609ee": [ "2al07",	313,	237,	"2am07",	"cold",	"middle" ]
  "2315386938a609ee": [ "2al08",	323,	237,	"2am08",	"cold",	"left" ]
  "231e2d6938a609ee": [ "2al10",	344,	237,	"2am10",	"cold",	"left" ]
  "2370857838a609ee": [ "2al11",	355,	237,	"2am11",	"cold",	"left" ]
  "232a896938a609ee": [ "2al12",	370,	237,	"2am12",	"cold",	"left" ]
  "23338b7838a609ee": [ "2an06",	303,	256,	"2am06",	"hot",	"right" ]
  "2313776938a609ee": [ "2an07",	313,	256,	"2am07",	"hot",	"right" ]
  "23621b6938a609ee": [ "2an08",	323,	256,	"2am08",	"hot",	"right" ]
  "236f976938a609ee": [ "2an10",	344,	256,	"2am10",	"hot",	"right" ]
  "2308637838a609ee": [ "2an11",	355,	256,	"2am11",	"hot",	"right" ]
  "2361626938a609ee": [ "2an12",	370,	256,	"2am12",	"hot",	"right" ]
  "2344816938a609ee": [ "2ap06",	299,	276,	"2aq06",	"hot",	"right" ]
  "2357b27838a609ee": [ "2ap07",	310,	276,	"2aq07",	"hot",	"right" ]
  "234a577838a609ee": [ "2ap08",	322,	276,	"2aq08",	"hot",	"right" ]
  "230d716938a609ee": [ "2ap09",	332,	276,	"2aq09",	"hot",	"right" ]
  "235a4d7838a609ee": [ "2ap11",	355,	276,	"2aq11",	"hot",	"right" ]
  "2335446938a609ee": [ "2ap12",	366,	276,	"2aq12",	"hot",	"right" ]
  "2303746938a609ee": [ "2ap13",	378,	276,	"2aq13",	"hot",	"right" ]
  "235c747838a609ee": [ "2ap14",	390,	276,	"2aq14",	"hot",	"right" ]
  "2378926938a609ee": [ "2ar06",	299,	291,	"2aq06",	"cold",	"middle" ]
  "232d2b6938a609ee": [ "2ar07",	310,	291,	"2aq07",	"cold",	"middle" ]
  "23158c6938a609ee": [ "2ar08",	322,	291,	"2aq08",	"cold",	"right" ]
  "236b5d7838a609ee": [ "2ar09",	332,	291,	"2aq09",	"cold",	"right" ]
  "2343a07838a609ee": [ "2ar11",	355,	291,	"2aq11",	"cold",	"right" ]
  "2362a67838a609ee": [ "2ar12",	366,	291,	"2aq12",	"cold",	"right" ]
  "23534b6938a609ee": [ "2ar13",	378,	291,	"2aq13",	"cold",	"right" ]
  "2311836938a609ee": [ "2ar14",	390,	291,	"2aq14",	"cold",	"right" ]
  "233c957838a609ee": [ "2bc02",	257,	406,	"2bd02",	"hot",	"left" ]
  "231f966938a609ee": [ "2bc03",	268,	406,	"2bd03",	"hot",	"left" ]
  "2360a97838a609ee": [ "2bc04",	279,	406,	"2bd04",	"hot",	"left" ]
  "2345767838a609ee": [ "2bc06",	300,	406,	"2bd06",	"hot",	"left" ]
  "23531b6938a609ee": [ "2be02",	257,	422,	"2bd02",	"cold",	"left" ]
  "23531b6938a609ee": [ "2be03",	268,	422,	"2bd03",	"cold",	"left" ]
  "233d167838a609ee": [ "2be04",	279,	422,	"2bd04",	"cold",	"left" ]
  "2359817838a609ee": [ "2be06",	300,	422,	"2bd06",	"cold",	"left" ]