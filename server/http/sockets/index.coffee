passport = require 'passport'
cookieParser = require 'cookie-parser'
passportSocketIO = require 'passport.socketio'
app = require '../express'
io = require('socket.io')(app)

io.set 'authorization', passportSocketIO.authorize
  passport: passport
  cookieParser: cookieParser
  key: config.session.key
  secret: config.session.secret
  store: sessionStore
  fail: (data, message, error, accept) ->
    accept null, true
  success: (data, accept) ->
    accept null, true

io.on 'connection', (socket) ->
  socket.on 'test', (data) ->
    console.log data


module.exports = io
