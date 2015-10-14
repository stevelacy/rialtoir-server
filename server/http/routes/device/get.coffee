{Device} = require '../../../db'

module.exports = (req, res, next) ->
  return next() unless req.user?.authorized
  Device.findById req.params.id, (err, device) ->
    return next err if err?
    res.json device
