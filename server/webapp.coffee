passport = require "./passport"
config = require "../config"
io = require "./sockets"
app = require "./express"
db = require "./db"
send = require "./functions/send"

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
  Device.findOne {number: req.body.number}, (err, device) ->
    console.log err if err?
    if device?
      device.set gcmId: req.body.id
      return device.save (err, out) ->
        console.log err, out

    newDevice = new Device
      gcmId: req.body.id
      number: req.body.number

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
  io.sockets.emit "gps",
    key: req.body.key
    lat: req.body.lat
    lon: req.body.lon
    number: req.body.number

  console.log req.body

app.post "/panic", (req, res) ->
  res.send 204
  ## this is disabled
  console.log req.body
  Device.findOneAndUpdate {number: req.body.number}, {panic: true}, (err, device) ->
    console.log err if err?
    console.log "Device called panic ", device
  Device.find {key: req.body.key}, (err, devices) ->
    devices.forEach (v, k) ->
      return console.log "origin" if v.number is req.body.number
      send.panic v._id, "sos", req.body.number, (err, result) ->
        console.log err if err?
        console.log "Alerting:", result
