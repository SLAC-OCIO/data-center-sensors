
Meteor.startup ->
  inDevelopment = ->
    process.env.NODE_ENV is "development"

  inProduction = ->
    process.env.NODE_ENV is "production"

  process.env.MONGO_URL = "mongodb://localhost:27017/dc"  if inProduction()
  console.log "DB is local, this is not production"  if inDevelopment() is true
  console.log "DB is standalone as you are in production mode"  if inProduction() is true
  return