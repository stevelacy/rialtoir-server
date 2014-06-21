passport = require "./passport"
config = require "../config"
io = require "./sockets"
app = require "./express"
db = require "./db"

Device = db.models.Device
User = db.models.User


app.get "/", (req, res) ->
  Device.find {}, (err, devices) ->
    res.render "index", user: req.user, items: devices

app.get "/map/:number", (req, res) ->
  res.render "map", {number: req.params.number}

app.get "/logout", (req, res) ->
  req.logout()
  res.redirect "/"

app.get "/login", (req, res) ->
  return res.redirect "/" if req.user?
  res.render "login"


app.get "/auth/twitter", passport.authenticate "twitter"
app.get "/auth/twitter/callback",
  passport.authenticate "twitter",
    successRedirect:"/"
    falureRedirect:"/login"



## Android GCM
app.post "/gcm", (req, res) ->
  res.send 204
  console.log "Registering #{req.body.number}"
  Device.findOne {gcmId: req.body.id}, (err, device) ->
    console.log err if err?
    return device if device
    newDevice = new Device()
    deviceData =
      gcmId: req.body.id
      number: req.body.number
      key: req.body.key
    newDevice.set deviceData
    newDevice.save (err, data) ->
      return console.log err if err?
      console.log data

## Android login

app.post "/login", (req, res) ->
  console.log "Android login: ", req.body
  User.findOne {username: req.body.user, key: req.body.key}, (err, user) ->
    console.log err, user
    return res.send "null" if err?
    return res.send "null" unless user?
    res.send "status:loggedin"

## Android GCM
app.post "/gps", (req, res) ->
  res.send "data"
  User.findOne {key: req.body.key}, (err, user) ->
    return console.log err if err?
    return console.log "no user" unless user?
    io.sockets.in(user.id).emit "gps",
      key: req.body.key
      lat: req.body.lat
      lon: req.body.lon
      number: req.body.number

  #io.sockets.in(req.body.number).emit("test", "data")
  console.log req.body
  ###
  console.log "Registering #{req.body.number}"
  Device.findOne {gcmId: req.body.id}, (err, device) ->
    console.log err if err?
    return device if device
    newDevice = new Device()
    deviceData =
      gcmId: req.body.id
      number: req.body.number
    newDevice.set deviceData
    newDevice.save (err, data) ->
      return console.log err if err?
      console.log data
  ###