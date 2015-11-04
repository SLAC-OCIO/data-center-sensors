#the model.js file is important.  This file is good for server and client
@heat = null
@legendCanvas = null
@legendCtx = null
@Sensors = new Mongo.Collection 'sensors'

Meteor.methods
  findSensors: () ->
    @Sensors.find()
