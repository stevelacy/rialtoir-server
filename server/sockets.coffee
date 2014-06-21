passport = require 'passport'
cookieParser = require 'cookie-parser'
passportSocketIO = require 'passport.socketio'

config = require '../config'
sessionStore = require './sessionstore'
server = require './httpserver'

io = require('socket.io')(server)


# functions
send = require "./functions/send"


io.set 'authorization', passportSocketIO.authorize
  cookieParser: cookieParser
  key: config.session.name
  secret: config.session.secret
  store: sessionStore
  fail: (data, message, critical, accept) ->
    console.log 'io session failed'
    accept null, false
  success: (data, accept) ->
    console.log 'io session success'
    accept null, true



io.on 'connection', (socket) ->
  return console.log 'socket error - user not authorized' unless socket.client.request.user?
  user = socket.client.request.user
  socket.join user.id

  socket.on "panic", (data) ->
    send data.id, "0", (err, res) ->
      console.log err, res

  socket.on "gps", (data) ->
    send data.id, "1", (err, res) ->
      console.log err, res

module.exports = io
