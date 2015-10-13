{Device} = require '../../../db'

module.exports = (req, res, next) ->
  return next() unless req.user?.authorized
  Device.find {}, (err, devices) ->
    return next err if err?
    res.json devices
