Meteor.startup ->
  Inject.rawModHtml 'addUnresolved', (html) ->
      html = html.replace '<body>', '<body unresolved fit layout vertical>'

  console.log "starting server..."

 Api = new Restivus
    useDefaultAuth: true
    prettyJson: true

  Api.addCollection Sensors
