passport = require 'passport'
cookieParser = require 'cookie-parser'
passportSocketIO = require 'passport.socketio'

config = require '../config'
sessionStore = require './sessionstore'
server = require './httpserver'
db = require "./db"

io = require('socket.io')(server)

Device = db.models.Device

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

  socket.on "clear", (data) ->
    Device.findOneAndUpdate {_id: data.id}, {panic: false}, (err, device) ->
      console.log err if err?
      console.log device

module.exports = io
