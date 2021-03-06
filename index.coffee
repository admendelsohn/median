#
# Main app file. Loads the .env file, runs setup code, and starts the server.
# This code should be kept to a minimum. Any setup code that gets large should
# be abstracted into modules under /lib.
#
express = require "express"
setup = require "./lib/setup"
{ RESTART_INTERVAL } = require "./config"

app = module.exports = express()
setup app

# Start the server and send a message to IPC for the integration test
# helper to hook into.
app.listen process.env.PORT, ->
  console.log "Listening on port " + process.env.PORT
  process.send? "listening"

# Reboot for memory leak
setTimeout process.exit, RESTART_INTERVAL
