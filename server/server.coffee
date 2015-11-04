
Meteor.startup ->
  console.log "starting server..."

  if Meteor.isServer
    Api = new Restivus
      useDefaultAuth: true
      prettyJson: true

    Api.addCollection Sensors
