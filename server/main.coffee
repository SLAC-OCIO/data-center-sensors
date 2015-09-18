# Sensors = new Mongo.Collection 'sensors'

Api = new Restivus
  useDefaultAuth: true
  prettyJson: true
  
Api.addCollection Sensors