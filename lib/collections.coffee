@Sensors = new Mongo.Collection 'sensors'

Meteor.methods
  findSensors: () ->
    @Sensors.find()