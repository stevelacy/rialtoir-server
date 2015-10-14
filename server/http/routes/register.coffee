{Device} = require '../../db'

module.exports = (req, res, next) ->
  Device.findOne number: req.body.number, (err, device) ->
    if device?
      device.set req.body
      device.save (err, doc) ->
        console.log doc, 'updated'
        return next err if err?
        res.sendStatus 200
    else
      device = new Device req.body
      device.save (err, doc) ->
        console.log doc, 'created'
        return next err if err?
        res.sendStatus 200
