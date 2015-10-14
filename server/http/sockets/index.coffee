passport = require 'passport'
cookieParser = require 'cookie-parser'
passportSocketIO = require 'passport.socketio'
reqDir = require 'require-dir'
server = require '../httpServer'
config = require '../../config'
io = require('socket.io')(server)
sessionStore = require '../express/sessionStore'

io.set 'authorization', passportSocketIO.authorize
  passport: passport
  cookieParser: cookieParser
  key: config.session.key
  secret: config.session.secret
  store: sessionStore
  fail: (data, message, error, accept) ->
    console.log 'io failed'
    accept null, true
  success: (data, accept) ->
    console.log 'io success'
    accept null, true

events = reqDir './events'
io.on 'connection', (socket) ->
  socket.on 'gps', events.gps
  socket.on 'panic', events.panic


module.exports = io
