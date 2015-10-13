
{Location, Device} = require '../../db'
io = require '../sockets'

module.exports = (req, res, next) ->
  Device.findOne number: req.body.number, (err, device) ->
    console.log device
    return next err if err?
    return next() unless device?
    location = new Location
      device: device._id
      lat: req.body.lat
      lon: req.body.lon
    location.save (err, location) ->
      return next err if err?
      io.emit 'location', location
      res.sendStatus 201
