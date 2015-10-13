{Message, Sender} = require 'node-gcm'
config = require '../config'

module.exports =
  send: (opts, device, cb) ->
    return unless device?
    message = new Message opts
    sender = new Sender config.gcm.key

    ids = [device.id]
    if device[0]?
      ids = device

    sender.send message, registrationIds: ids, cb
