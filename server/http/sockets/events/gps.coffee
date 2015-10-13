{Device} = require '../../../db'
{send} = require '../../../lib/gcm'

module.exports = (data) ->
  Device.findById data.device, (err, device) ->
    return console.error err if err?
    return unless device?

    opts =
      data:
        action: 'gps'

    console.log opts, device
    send opts, device, (err, data) ->
      console.log err, data
