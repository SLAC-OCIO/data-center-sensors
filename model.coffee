#the model.js file is important.  This file is good for server and client
@Sensors = new Meteor.Collection("sensors")

Meteor.methods
  findSensors: () ->
    @Sensors.find()
