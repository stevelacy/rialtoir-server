req = require 'require-dir'
app = require './express'

passport = require './passport'
routes = req './routes', recurse: true

app.get '/api/devices/:id', routes.device.get
app.get '/api/devices', routes.device.getAll

app.get '/test', routes.test
app.post '/register', routes.register
app.post '/gps', routes.gps
app.post '/panic', routes.panic


spa = require './express/spa'
sockets = require './sockets'
httpServer = require './httpServer'

module.exports = httpServer
