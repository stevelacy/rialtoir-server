async = require 'async'
{send} = require '../../lib/gcm'
{Device} = require '../../db'

module.exports = (req, res, next) ->
  Device.findOne number: req.body.number, (err, device) ->
    return next err if err?
    return next() unless device?

    opts =
      data:
        action: 'panic'

    Device.find {}, (err, devices) ->
      return next err if err?
      return res.end() unless devices?

      deviceIds = []
      async.each devices, (v, cb) ->
        return cb() if String(device._id) is String v._id
        deviceIds.push v.id
        cb()
      , (err) ->
        return next err if err?
        return res.end() unless deviceIds[0]?
        send opts, deviceIds, (err, data) ->
          console.error err if err?
          console.log data
          res.end()
