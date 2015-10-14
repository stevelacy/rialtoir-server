{Device} = require '../../../db'
{send} = require '../../../lib/gcm'

module.exports = (data) ->
  Device.findById data.device, (err, device) ->
    return console.error err if err?
    return unless device?

    opts =
      data:
        action: 'panic'

    send opts, device, (err, data) ->
      console.log err, data
